import Chart from 'chart.js';

 const initChart = () => {


var ctx = document.getElementById("myChart");

// const myStatus = JSON.parse(ctx.canvas.dataset.deliveries)
const livred = ctx.dataset.livred
const delayed = ctx.dataset.delayed
const rest = ctx.dataset.rest

var myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
    datasets: [{
        backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)'
                ],
        // data: [livred, delayed, rest]
        data: [3, 4, 6]
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
        'Livré',
        'Retard',
        'Enregistré'
    ]
    }
});
}

 export { initChart }
