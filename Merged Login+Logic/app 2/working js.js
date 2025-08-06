document.addEventListener('DOMContentLoaded', function() {
    // Mode switching
    document.getElementById('manualMode').addEventListener('click', function() {
        this.classList.add('active');
        document.getElementById('weatherMode').classList.remove('active');
        document.getElementById('manualForm').style.display = 'block';
        document.getElementById('weatherForm').style.display = 'none';
        document.getElementById('output').style.display = 'none';
    });

    document.getElementById('weatherMode').addEventListener('click', function() {
        this.classList.add('active');
        document.getElementById('manualMode').classList.remove('active');
        document.getElementById('weatherForm').style.display = 'block';
        document.getElementById('manualForm').style.display = 'none';
        document.getElementById('output').style.display = 'none';
    });

    // Print button
    document.getElementById('printPlan').addEventListener('click', function() {
        window.print();
    });

    // Form submissions
    document.getElementById('generateManualPlan').addEventListener('click', generateManualPlan);
    document.getElementById('generateWeatherPlan').addEventListener('click', generateWeatherPlan);
});

function generateManualPlan() {
    const location = document.getElementById('manualLocation').value;
    const crop = document.getElementById('manualCrop').value;
    
    if (!location || !crop) {
        showAlert('Please select both location and crop', 'error');
        return;
    }

    fetch('/generate_plan', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            district: location,
            crop: crop,
            mode: "manual"
        })
    })
    .then(response => response.json())
    .then(data => displayPlan(data))
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to generate plan. Please try again.', 'error');
    });
}

function generateWeatherPlan() {
    const location = document.getElementById('weatherLocation').value;
    const crop = document.getElementById('weatherCrop').value;
    
    if (!location || !crop) {
        showAlert('Please enter location and select crop', 'error');
        return;
    }

    fetch('/generate_plan', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            district: location,
            crop: crop,
            mode: "weather"
        })
    })
    .then(response => response.json())
    .then(data => displayPlan(data))
    .catch(error => {
        console.error('Error:', error);
        showAlert('Failed to fetch weather data. Please try again.', 'error');
    });
}

function displayPlan(data) {
    if (data.error) {
        showAlert(data.error, 'error');
        return;
    }
    
    const outputTitle = document.getElementById('outputTitle');
    const outputContent = document.getElementById('outputContent');
    
    outputTitle.innerHTML = `<i class="fas fa-clipboard-list"></i> ${data.type === 'weather' ? 'Weekly' : 'Manual'} Plan for ${data.crop} in ${data.location}`;
    
    if (data.type === 'weather') {
        let tableHTML = `
            <table class="irrigation-table">
                <thead>
                    <tr>
                        <th><i class="far fa-calendar-alt"></i> Date</th>
                        <th><i class="fas fa-cloud"></i> Weather</th>
                        <th><i class="fas fa-thermometer-half"></i> Temp</th>
                        <th><i class="fas fa-tint"></i> Rain</th>
                        <th><i class="fas fa-water"></i> Irrigate?</th>
                        <th><i class="fas fa-exclamation-triangle"></i> Alerts</th>
                    </tr>
                </thead>
                <tbody>
        `;
        
        data.plan.forEach(day => {
            let rowClass = "";
            if (day[5].includes("✅")) rowClass = "irrigate-yes";
            else if (day[5].includes("❌")) rowClass = "irrigate-no";
            else rowClass = "irrigate-partial";

            tableHTML += `
                <tr class="${rowClass}">
                    <td>${day[0]}</td>
                    <td>${day[1]}</td>
                    <td>${day[2]}</td>
                    <td>${day[3]}</td>
                    <td>${day[5]}</td>
                    <td>${day[6]}</td>
                </tr>
            `;
        });
        
        tableHTML += `</tbody></table>`;
        outputContent.innerHTML = tableHTML;
    } else {
        outputContent.innerHTML = `
            <div class="info-card">
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-tint"></i> Average Rainfall:</span>
                    <span class="info-value">${data.avg_rainfall || 'N/A'}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-water"></i> Recommended Irrigation:</span>
                    <span class="info-value">${data.irrigation_req || 'Moderate'}</span>
                </div>
                <div class="info-item">
                    <span class="info-label"><i class="fas fa-seedling"></i> Soil Type:</span>
                    <span class="info-value">${data.soil_type || 'Loamy'}</span>
                </div>
            </div>
            <h3 class="plan-title"><i class="fas fa-tasks"></i> Weekly Plan</h3>
            <ul class="plan-list">
                ${data.weeks ? data.weeks.map(week => `<li>${week}</li>`).join('') : '<li>No plan available</li>'}
            </ul>
            <div class="weather-alert">
                <i class="fas fa-info-circle"></i> Note: This is general advisory. For real-time recommendations, use Weather Mode.
            </div>
        `;
    }
    
    document.getElementById('output').style.display = 'block';
    window.scrollTo({
        top: document.getElementById('output').offsetTop - 20,
        behavior: 'smooth'
    });
}

function showAlert(message, type) {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.innerHTML = `
        <i class="fas fa-${type === 'error' ? 'exclamation-circle' : 'check-circle'}"></i> ${message}
    `;
    
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.classList.add('fade-out');
        setTimeout(() => alertDiv.remove(), 500);
    }, 3000);
}