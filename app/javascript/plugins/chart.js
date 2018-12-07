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

  var ctx2 = document.getElementById("myChart2");
var myChart = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            label: '# of Votes',
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ]},
            {
            data: [4, 10, 6, 7, 1, 6],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});




}

 export { initChart }
