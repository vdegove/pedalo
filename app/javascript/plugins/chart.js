import Chart from 'chart.js';

 const initChart = () => {


var ctx = document.getElementById("myChart");

if (ctx) {

// const myStatus = JSON.parse(ctx.canvas.dataset.deliveries)
const delivered = ctx.dataset.delivered
const enregistred = ctx.dataset.enregistred
const in_process = ctx.dataset.in_process

Chart.defaults.global.defaultFontFamily = "Rubik";
var myChart = new Chart(ctx, {
    type: 'doughnut',
    options: {
      circumference: Math.PI,
      rotation: Math.PI,
      legend: {
        position: 'bottom',
        fullWidth: true,
        labels: {
          fontSize: 12
        }
      }

    },
    data: {
    datasets: [{
        backgroundColor: [
                    'rgb(37, 177, 190)',
                    'rgb(103, 107, 118)',
                    'rgb(226, 222, 132)'
                ],
        data: [delivered, in_process, enregistred]
        // data: [6, 4, 6, 3]
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
        'Livré',
        'En cours',
        'Enregistré'
    ]
    }
});


}

}


 export { initChart }
