// LOAD BUSES (dummy data for now)
function loadBuses() {
    const buses = [
        { bus_number: "B1", capacity: 40 },
        { bus_number: "B2", capacity: 35 }
    ];

    let list = document.getElementById("busList");
    list.innerHTML = "";

    buses.forEach(bus => {
        let li = document.createElement("li");
        li.innerText = bus.bus_number + " - Capacity: " + bus.capacity;
        list.appendChild(li);
    });
}

// LOAD ROUTES (dummy data)
function loadRoutes() {
    const routes = [
        { source: "Gate", destination: "Hostel" },
        { source: "Library", destination: "Cafeteria" }
    ];

    let list = document.getElementById("routeList");
    list.innerHTML = "";

    routes.forEach(route => {
        let li = document.createElement("li");
        li.innerText = route.source + " → " + route.destination;
        list.appendChild(li);
    });
}

// AI FUNCTION (same as before)
function predictDelay() {
    let traffic = document.getElementById("traffic").value;
    let distance = document.getElementById("distance").value;

    if (!traffic || !distance) {
        document.getElementById("result").innerText = "⚠️ Enter values!";
        return;
    }

    document.getElementById("result").innerText = "⏳ Predicting...";

    fetch("http://127.0.0.1:5000/predict", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            traffic: parseInt(traffic),
            distance: parseInt(distance)
        })
    })
    .then(res => res.text())
    .then(data => {
        document.getElementById("result").innerText =
            "🚦 Predicted Delay: " + data + " minutes";
    })
    .catch(err => {
        document.getElementById("result").innerText =
            "❌ Error connecting to server";
    });
}