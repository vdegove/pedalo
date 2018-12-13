import Chart from 'chart.js';

 const initChart = () => {


var ctx = document.getElementById("myChart");

if (ctx) {

// const myStatus = JSON.parse(ctx.canvas.dataset.deliveries)
const delivered = ctx.dataset.delivered
const enregistred = ctx.dataset.enregistred
const in_process = ctx.dataset.in_process
const delayed = ctx.dataset.delayed

Chart.defaults.global.defaultFontFamily = "Rubik";
var myChart = new Chart(ctx, {
    type: 'doughnut',
    options: {
      circumference: Math.PI,
      rotation: Math.PI,
      legend: false

    },
    data: {
    datasets: [{
        backgroundColor: [
                    'rgb(8, 103, 136)',
                    'rgb(242, 130, 130)',
                    'rgb(31, 187, 198)',
                    'rgb(225, 229, 224)'

                ],
        data: [delivered, delayed, in_process, enregistred]
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
        'Livré',
        'En retard',
        'En cours',
        'Enregistré'

    ]
    }
});


}

}


 export { initChart }
