document.addEventListener('DOMContentLoaded', function() {
    // Initialize all application components
    try {
        initModeSwitching();
        initPrintButton();
        initFormSubmissions();
        initDistrictCropLoading();
        initYearlyPlan();
        loadStates(); // Load states when page loads
    } catch (error) {
        console.error('Application initialization failed:', error);
        showAlert('Failed to initialize application. Please refresh the page.', 'error');
    }
});

// ======================
// MODE MANAGEMENT
// ======================

function initModeSwitching() {
    // Set up mode buttons
    document.getElementById('manualMode').addEventListener('click', () => switchMode('manual'));
    document.getElementById('weatherMode').addEventListener('click', () => switchMode('weather'));
    document.getElementById('yearlyMode').addEventListener('click', () => switchMode('yearly'));
    
    // Set default mode to weather
    switchMode('weather');
}

function switchMode(mode) {
    // Validate mode
    const validModes = ['manual', 'weather', 'yearly'];
    if (!validModes.includes(mode)) {
        console.error('Invalid mode:', mode);
        return;
    }

    // Update active button states
    document.querySelectorAll('.mode-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    document.getElementById(`${mode}Mode`).classList.add('active');
    
    // Show/hide forms
    document.getElementById('manualForm').style.display = mode === 'manual' ? 'block' : 'none';
    document.getElementById('weatherForm').style.display = mode === 'weather' ? 'block' : 'none';
    document.getElementById('yearlyForm').style.display = mode === 'yearly' ? 'block' : 'none';
    
    // Reset output when switching modes
    hideOutput();
}

// ======================
// YEARLY PLAN SECTION
// ======================

// YEARLY PLAN FUNCTIONS
function initYearlyPlan() {
    const stateSelect = document.getElementById('yearlyState');
    const districtSelect = document.getElementById('yearlyDistrict');
    const generateBtn = document.getElementById('generateYearlyPlan');

    // Load states on page load
    loadStates();

    stateSelect.addEventListener('change', async function() {
        const stateId = this.value;
        districtSelect.disabled = true;
        generateBtn.disabled = true;
        
        if (!stateId) {
            districtSelect.innerHTML = '<option value="">-- Select State First --</option>';
            return;
        }
        
        try {
            districtSelect.innerHTML = '<option value="">Loading districts...</option>';
            const response = await fetch('/get_districts_by_state', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ state_id: stateId })
            });
            
            const data = await response.json();
            if (!data.success) {
                throw new Error(data.error || 'Failed to load districts');
            }
            
            districtSelect.innerHTML = '<option value="">-- Select District --</option>';
            data.districts.forEach(district => {
                const option = new Option(district.name, district.id);
                districtSelect.add(option);
            });
            districtSelect.disabled = false;
        } catch (error) {
            console.error('District loading failed:', error);
            districtSelect.innerHTML = '<option value="">Error loading districts</option>';
            showAlert('Failed to load districts. Please try again.', 'error');
        }
    });

    districtSelect.addEventListener('change', function() {
        generateBtn.disabled = !this.value;
    });

    generateBtn.addEventListener('click', generateYearlyPlan);
}

async function generateYearlyPlan() {
    const districtSelect = document.getElementById('yearlyDistrict');
    const districtId = districtSelect.value;
    
    if (!districtId) {
        showAlert('Please select a district first', 'error');
        return;
    }

    try {
        // Show loading state
        const btn = document.getElementById('generateYearlyPlan');
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
        
        const response = await fetch('/get_yearly_plan', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ district_id: districtId })
        });
        
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.error || 'Server error');
        }
        
        if (data.error) {
            throw new Error(data.error);
        }
        
        displayYearlyPlan(data);
        
    } catch (error) {
        console.error('Yearly plan failed:', error);
        showAlert(`Yearly plan failed: ${error.message}`, 'error');
    } finally {
        const btn = document.getElementById('generateYearlyPlan');
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-seedling"></i> Generate Plan';
    }
}

function generateCropCard(crop, season) {
    const cropId = `${crop.crop.replace(/\s+/g, '_')}_${season}`;
    window._cropMap[cropId] = crop;  // ✅ This line is essential

    return `
        <div class="crop-card ${season.toLowerCase()}">
            ...
            <button class="view-plan-btn" id="btn-${cropId}">
                <i class="fas fa-book-open"></i> View Detailed Plan
            </button>
        </div>
    `;
}


// Helper functions
function getSeasonIcon(season) {
    const icons = { 'Kharif': 'sun', 'Rabi': 'snowflake', 'Zaid': 'cloud-sun' };
    return icons[season] || 'calendar';
}

function getSeasonMonths(season) {
    const months = {
        'Kharif': 'June - September',
        'Rabi': 'October - March',
        'Zaid': 'March - June'
    };
    return months[season] || '';
}
function generateCropCard(crop, season) {
    const cropId = `${crop.crop.replace(/\s+/g, '_')}_${season}`;
    window._cropMap[cropId] = crop;  // ✅ This line is essential

    return `
        <div class="crop-card ${season.toLowerCase()}">
            ...
            <button class="view-plan-btn" id="btn-${cropId}">
                <i class="fas fa-book-open"></i> View Detailed Plan
            </button>
        </div>
    `;
}



function viewCropPlan(crop) {
    const container = document.getElementById('detailedPlanContent');
    container.innerHTML = `
        <h3>Detailed Plan for ${crop.crop}</h3>
        <p><strong>Yield:</strong> ${crop.yield}</p>
        <p><strong>Soil:</strong> ${crop.soil}</p>
        <p><strong>Irrigation:</strong> ${crop.irrigation}</p>
        <p><strong>Disease Risk:</strong> ${crop.disease || 'None'}</p>
        <p><strong>Treatment:</strong> ${crop.treatment || 'N/A'}</p>
        <p><strong>Sowing Month:</strong> ${crop.sowing_month || 'N/A'}</p>
        <p><strong>Harvest Month:</strong> ${crop.harvest_month || 'N/A'}</p>
        <p><strong>Estimated Growth Duration:</strong> ${crop.growth_duration || 'N/A'} days</p>
        <button onclick="closeDetailedPlan()">Close</button>
    `;
    document.getElementById('detailedPlan').style.display = 'flex';
}

function closeDetailedPlan() {
    document.getElementById('detailedPlan').style.display = 'none';
}



async function loadStates() {
    const stateSelect = document.getElementById('yearlyState');
    try {
        setLoadingState(stateSelect, true, 'Loading states...');
        const states = await fetchStates();
        populateStateDropdown(stateSelect, states);
    } catch (error) {
        console.error('State loading failed:', error);
        setLoadingState(stateSelect, false, 'Error loading states');
        showAlert('Failed to load states. Please refresh the page.', 'error');
    }
}

async function fetchStates() {
    const response = await fetch('/get_states');
    const data = await response.json();
    if (!data.success) {
        throw new Error(data.error || 'Failed to load states');
    }
    return data.states;
}

async function fetchDistrictsByState(stateId) {
    const response = await fetch('/get_districts_by_state', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ state_id: stateId })
    });
    const data = await response.json();
    if (!data.success) {
        throw new Error(data.error || 'Failed to load districts');
    }
    return data.districts;
}
// Add this to your script.js
function showCropDetails(crop, season) {
    // Create modal container
    const modal = document.createElement('div');
    modal.className = 'crop-modal';
    modal.innerHTML = `
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h3>Detailed Plan for ${crop} (${season})</h3>
            <div class="crop-details">
                <p><strong>Season:</strong> ${season} (${getSeasonMonths(season)})</p>
                <p><strong>Recommended Practices:</strong></p>
                <ul>
                    <li>Soil Preparation: 2 weeks before planting</li>
                    <li>Planting Method: ${season === 'Kharif' ? 'Direct seeding' : 'Transplanting'}</li>
                    <li>Irrigation Schedule: Weekly during dry spells</li>
                    <li>Fertilizer Application: NPK 100:50:50 kg/ha</li>
                </ul>
                <p><strong>Harvest:</strong> ${season === 'Kharif' ? 'September-October' : 'March-April'}</p>
            </div>
        </div>
    `;

    // Add to DOM
    document.body.appendChild(modal);

    // Close button handler
    modal.querySelector('.close-btn').addEventListener('click', () => {
        modal.remove();
    });
}

function populateStateDropdown(selectElement, states) {
    selectElement.innerHTML = '<option value="">-- Select State --</option>';
    states.forEach(state => {
        const option = new Option(state.name, state.id);
        selectElement.add(option);
    });
    selectElement.disabled = false;
}

function populateDistrictDropdown(selectElement, districts) {
    selectElement.innerHTML = '<option value="">-- Select District --</option>';
    districts.forEach(district => {
        const option = new Option(district.name, district.id);
        selectElement.add(option);
    });
    selectElement.disabled = false;
}

function resetDistrictDropdown() {
    const districtSelect = document.getElementById('yearlyDistrict');
    districtSelect.innerHTML = '<option value="">Select state first</option>';
    districtSelect.disabled = true;
}

function setLoadingState(selectElement, isLoading, message) {
    selectElement.innerHTML = `<option value="">${message}</option>`;
    selectElement.disabled = isLoading;
}

async function generateYearlyPlan() {
    const districtSelect = document.getElementById('yearlyDistrict');
    const districtId = districtSelect.value;
    const districtName = districtSelect.options[districtSelect.selectedIndex].text;
    
    if (!districtId) {
        showAlert('Please select a district first', 'error');
        return;
    }

    try {
        showLoading(true, 'yearly');
        const response = await fetch('/get_yearly_plan', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ district_id: districtId })
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        if (data.error) {
            throw new Error(data.error);
        }
        
        // Add district name to the response data for display
        data.district = districtName;
        displayYearlyPlan(data);
    } catch (error) {
        console.error('Yearly plan generation failed:', error);
        showAlert(error.message || 'Failed to generate yearly plan', 'error');
    } finally {
        showLoading(false, 'yearly');
    }
}

// ======================
// DISTRICT-CROP LOADING
// ======================

function initDistrictCropLoading() {
    document.getElementById('manualLocation').addEventListener('change', function() {
        loadCrops(this.value, 'manualCrop');
    });
    
    document.getElementById('weatherLocation').addEventListener('change', function() {
        loadCrops(this.value, 'weatherCrop');
    });
}

async function loadCrops(district, targetSelectId) {
    if (!district) {
        resetCropDropdown(targetSelectId);
        return;
    }
    
    const cropSelect = document.getElementById(targetSelectId);
    try {
        setLoadingState(cropSelect, true, 'Loading crops...');
        const crops = await fetchCrops(district);
        populateCropDropdown(cropSelect, crops);
    } catch (error) {
        console.error('Crop loading failed:', error);
        setLoadingState(cropSelect, false, 'Error loading crops');
        showAlert('Failed to load crops. Please try again.', 'error');
    }
}

async function fetchCrops(district) {
    const response = await fetch('/get_crops', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ district: district })
    });
    const data = await response.json();
    if (!data.success) {
        throw new Error(data.error || 'Failed to load crops');
    }
    return data.crops;
}

function populateCropDropdown(selectElement, crops) {
    selectElement.innerHTML = '<option value="">-- Select Crop --</option>';
    crops.forEach(crop => {
        const option = new Option(crop, crop);
        selectElement.add(option);
    });
    selectElement.disabled = false;
}

function resetCropDropdown(selectId) {
    const select = document.getElementById(selectId);
    select.innerHTML = '<option value="">Select district first</option>';
    select.disabled = true;
}

// ======================
// PLAN GENERATION
// ======================

function initFormSubmissions() {
    document.getElementById('generateManualPlan').addEventListener('click', generateManualPlan);
    document.getElementById('generateWeatherPlan').addEventListener('click', generateWeatherPlan);
}

async function generateManualPlan() {
    const location = document.getElementById('manualLocation').value;
    const crop = document.getElementById('manualCrop').value;
    
    if (!validateInputs(location, crop)) return;
    
    try {
        showLoading(true, 'manual');
        const planData = await fetchPlan(location, crop, 'manual');
        displayPlan(planData);
    } catch (error) {
        console.error('Manual plan generation failed:', error);
        showAlert(error.message || 'Failed to generate manual plan', 'error');
    } finally {
        showLoading(false, 'manual');
    }
}

async function generateWeatherPlan() {
    const location = document.getElementById('weatherLocation').value;
    const crop = document.getElementById('weatherCrop').value;
    
    if (!validateInputs(location, crop)) return;
    
    try {
        showLoading(true, 'weather');
        const planData = await fetchPlan(location, crop, 'weather');
        displayPlan(planData);
    } catch (error) {
        console.error('Weather plan generation failed:', error);
        showAlert(error.message || 'Failed to generate weather plan', 'error');
    } finally {
        showLoading(false, 'weather');
    }
}

async function fetchPlan(district, crop, mode) {
    const response = await fetch('/generate_plan', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            district: district,
            crop: crop,
            mode: mode
        })
    });
    
    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    if (data.error) {
        throw new Error(data.error);
    }
    
    return data;
}

// ======================
// PLAN DISPLAY
// ======================

function displayPlan(data) {
    if (!data) {
        showAlert('No plan data received', 'error');
        return;
    }

    const outputTitle = document.getElementById('outputTitle');
    const outputContent = document.getElementById('outputContent');
    
    outputTitle.innerHTML = `
        <i class="fas fa-clipboard-list"></i> 
        ${data.type === 'weather' ? 'Weekly' : 'Manual'} Plan for ${data.crop || ''} in ${data.location || ''}
        <span class="timestamp">${new Date().toLocaleDateString()}</span>
    `;
    
    outputContent.innerHTML = data.type === 'weather' 
        ? generateWeatherTable(data.plan || []) 
        : generateManualPlanContent(data);
    
    showOutput();
}

function displayYearlyPlan(data) {
    if (!data || !data.seasons) {
        showAlert('Invalid yearly plan data received', 'error');
        return;
    }

    const outputTitle = document.getElementById('outputTitle');
    const outputContent = document.getElementById('outputContent');

    outputTitle.innerHTML = `
        <i class="fas fa-calendar-alt"></i> 
        Yearly Plan for ${data.district || 'Selected District'}
        <span class="timestamp">${new Date().toLocaleDateString()}</span>
    `;

    // 🔑 Initialize the global crop map before generating anything
    window._cropMap = {};

    // ⬇️ Fill the HTML with crop cards
    outputContent.innerHTML = generateYearlyPlanContent(data);

    // ✅ Now bind the event listeners to each card
    setTimeout(() => {
        Object.keys(window._cropMap).forEach(cropId => {
            const btn = document.getElementById(`btn-${cropId}`);
            if (btn) {
                btn.addEventListener('click', () => {
                    viewCropPlan(window._cropMap[cropId]);
                });
            }
        });
    }, 0);

    showOutput();
}


function generateYearlyPlanContent(data) {
    return `
        <div class="yearly-plan-container">
            <div class="season-tabs">
                ${Object.keys(data.seasons).map(season => `
                    <button class="tab-btn ${season.toLowerCase()} ${season === 'Kharif' ? 'active' : ''}" 
                            onclick="showSeasonTab('${season}')">
                        ${season} Season
                    </button>
                `).join('')}
            </div>
            <div class="season-plans">
                ${Object.entries(data.seasons).map(([season, crops], index) => `
                    <div id="${season}-content" class="season-content" 
                         style="display: ${index === 0 ? 'block' : 'none'}">
                        <h3 class="season-title">
                            <i class="fas fa-${getSeasonIcon(season)}"></i>
                            ${season} Season (${getSeasonMonths(season)})
                        </h3>
                        ${crops.length > 0 ? `
                            <div class="crop-grid">
                                ${crops.map(crop => generateCropCard(crop, season)).join('')}
                            </div>
                        ` : '<p class="no-crops">No crops recommended for this season</p>'}
                    </div>
                `).join('')}
            </div>
        </div>
    `;
}

function generateCropCard(crop, season) {
    return `
        <div class="crop-card ${season.toLowerCase()}">
            <div class="crop-header">
                <h4><i class="fas fa-seedling"></i> ${crop.crop}</h4>
                <span class="yield-badge">${crop.yield || 'N/A'} kg/ha</span>
            </div>
            <div class="crop-details">
                <p><i class="fas fa-tint"></i> <strong>Irrigation:</strong> ${crop.irrigation || 'Moderate'}</p>
                <p><i class="fas fa-layer-group"></i> <strong>Soil:</strong> ${crop.soil || 'Various'}</p>
                ${crop.disease ? `
                    <div class="disease-alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>Watch for:</strong> ${crop.disease}
                        ${crop.treatment ? `<p class="treatment">Treatment: ${crop.treatment}</p>` : ''}
                    </div>
                ` : ''}
            </div>
            <button class="view-plan-btn" onclick='viewCropPlan(${JSON.stringify(crop)})'>
    <i class="fas fa-book-open"></i> View Detailed Plan
</button>

        </div>
    `;
}

function generateWeatherTable(plan) {
    if (!plan || plan.length === 0) {
        return '<div class="no-data">No weather data available</div>';
    }
    
    return `
        <div class="table-responsive">
            <table class="irrigation-table">
                <thead>
                    <tr>
                        <th><i class="far fa-calendar-alt"></i> Date</th>
                        <th><i class="fas fa-thermometer-half"></i> Max Temp</th>
                        <th><i class="fas fa-tint"></i> Rain</th>
                        <th><i class="fas fa-water"></i> Irrigation</th>
                        <th><i class="fas fa-exclamation-triangle"></i> Alerts</th>
                    </tr>
                </thead>
                <tbody>
                    ${plan.map(day => generateWeatherRow(day)).join('')}
                </tbody>
            </table>
        </div>
        <div class="weather-summary">
            <h4><i class="fas fa-chart-line"></i> Weekly Summary</h4>
            <p>Average Temperature: ${calculateAverage(plan, 1)}°C</p>
            <p>Total Rainfall: ${calculateTotal(plan, 2)}mm</p>
        </div>
    `;
}

function generateWeatherRow(day) {
    const rowClass = day[5]?.includes("✅") ? "irrigate-yes" : 
                    day[5]?.includes("❌") ? "irrigate-no" : "irrigate-partial";
    
    return `
        <tr class="${rowClass}">
            <td>${day[0] || 'N/A'}</td>
            <td>${day[1] || 'N/A'}</td>
            <td>${day[2] || 'N/A'}</td>
            <td>${day[5] || 'N/A'}</td>
            <td>${day[6] || 'No alerts'}</td>
        </tr>
    `;
}

function generateManualPlanContent(data) {
    return `
        <div class="manual-plan">
            <div class="plan-summary">
                <div class="summary-card">
                    <h4><i class="fas fa-info-circle"></i> Plan Summary</h4>
                    <div class="summary-item">
                        <i class="fas fa-tint"></i>
                        <span>Avg. Rainfall: <strong>${data.avg_rainfall || 'N/A'}</strong></span>
                    </div>
                    <div class="summary-item">
                        <i class="fas fa-water"></i>
                        <span>Irrigation: <strong>${data.irrigation?.requirement || 'Moderate'}</strong></span>
                    </div>
                    <div class="summary-item">
                        <i class="fas fa-seedling"></i>
                        <span>Soil: <strong>${data.soil_info?.type || 'Loamy'}</strong></span>
                    </div>
                </div>
            </div>
            <div class="weekly-plan">
                <h4><i class="fas fa-calendar-week"></i> Weekly Schedule</h4>
                <ul class="week-list">
                    ${data.weeks ? data.weeks.map(week => `<li>${week}</li>`).join('') : '<li>No plan available</li>'}
                </ul>
            </div>
        </div>
    `;
}

// ======================
// UTILITY FUNCTIONS
// ======================

function initPrintButton() {
    document.getElementById('printPlan').addEventListener('click', function() {
        window.print();
    });
}

function showOutput() {
    const output = document.getElementById('output');
    if (output) {
        output.style.display = 'block';
        scrollToElement(output);
    }
}

function hideOutput() {
    const output = document.getElementById('output');
    if (output) {
        output.style.display = 'none';
    }
}

function scrollToElement(element) {
    if (element) {
        element.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
}



function showLoading(show, type) {
    const button = document.getElementById(`generate${type.charAt(0).toUpperCase() + type.slice(1)}Plan`);
    if (button) {
        button.disabled = show;
        button.innerHTML = show ? 
            `<i class="fas fa-spinner fa-spin"></i> Processing...` : 
            type === 'yearly' ? 
                `<i class="fas fa-seedling"></i> Generate Plan` :
                `<i class="fas fa-calculator"></i> Generate Plan`;
    }
}

function showAlert(message, type = 'error') {
    // Remove existing alerts first
    document.querySelectorAll('.alert').forEach(alert => alert.remove());

    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.innerHTML = `
        <i class="fas fa-${type === 'error' ? 'exclamation-circle' : 'check-circle'}"></i> 
        ${message}
    `;
    
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.classList.add('fade-out');
        setTimeout(() => alertDiv.remove(), 500);
    }, 5000);
}

function validateInputs(location, crop) {
    if (!location) {
        showAlert('Please select a location', 'error');
        return false;
    }
    if (!crop) {
        showAlert('Please select a crop', 'error');
        return false;
    }
    return true;
}

function calculateAverage(plan, index) {
    const values = plan.map(day => parseFloat(day[index]?.replace(/[^\d.-]/g, '') || 0)).filter(val => !isNaN(val));
    if (values.length === 0) return 'N/A';
    return (values.reduce((a, b) => a + b, 0) / values.length).toFixed(1);
}

function calculateTotal(plan, index) {
    const values = plan.map(day => parseFloat(day[index]?.replace(/[^\d.-]/g, '') || 0)).filter(val => !isNaN(val));
    if (values.length === 0) return 'N/A';
    return values.reduce((a, b) => a + b, 0).toFixed(1);
}

function getSeasonIcon(season) {
    const icons = {
        'Kharif': 'sun',
        'Rabi': 'snowflake',
        'Zaid': 'cloud-sun'
    };
    return icons[season] || 'calendar';
}

function getSeasonMonths(season) {
    const months = {
        'Kharif': 'June - September',
        'Rabi': 'October - March',
        'Zaid': 'March - June'
    };
    return months[season] || '';
}

// Global functions needed for HTML event handlers
window.showSeasonTab = function(season) {
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    document.querySelector(`.tab-btn.${season.toLowerCase()}`).classList.add('active');
    
    document.querySelectorAll('.season-content').forEach(div => {
        div.style.display = 'none';
    });
    document.getElementById(`${season}-content`).style.display = 'block';
};

window.viewCropPlan = function(crop, season) {
    const modal = document.createElement('div');
    modal.className = 'crop-plan-modal';
    modal.innerHTML = `
        <div class="modal-content">
            <h3>Detailed Plan for ${crop} (${season})</h3>
            <p>This would show detailed cultivation practices, irrigation schedule, etc.</p>
            <button onclick="this.parentElement.parentElement.remove()">Close</button>
        </div>
    `;
    document.body.appendChild(modal);
};