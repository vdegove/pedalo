import Chart from 'chart.js';

 const initChart = () => {


var ctx = document.getElementById("myChart");

if (ctx) {

// const myStatus = JSON.parse(ctx.canvas.dataset.deliveries)
const livred = ctx.dataset.livred
const delayed = ctx.dataset.delayed
const rest = ctx.dataset.rest

var myChart = new Chart(ctx, {
    type: 'doughnut',
    options: {
      circumference: Math.PI,
      rotation: Math.PI,
      legend: {
        position: 'bottom',
        fullWidth: true,
        labels: {
          fontSize: 14
        }
      }

    },
    data: {
    datasets: [{
        backgroundColor: [
                    'rgba(70, 160, 70, 0.5)',
                    'rgba(250, 70, 70, 0.5)',
                    'rgba(160, 160, 160, 0.2)'
                ],
        // data: [livred, delayed, rest]
        data: [6, 4, 6]
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

  var ctx2 = document.getElementById("myChart2");

  if (ctx2) {
  var myChart = new Chart(ctx2, {
      type: 'bar',
      data: {
          options: {
            borderWidth: 1,
          },
          labels: ["Lundi", "Mardi", "mercredi", "Jeudi", "Vendredi", "Samedi"],
          datasets: [{
              label: 'Semaine en cours',
              data: [12, 19, 2, 2, 2, 2],
              backgroundColor: [
                  'rgba(54, 162, 235, 0.5)',
                  'rgba(54, 162, 235, 0.5)',
                  'rgba(54, 162, 235, 0.5)',
                  'rgba(54, 162, 235, 0.5)',
                  'rgba(54, 162, 235, 0.5)',
                  'rgba(54, 162, 235, 0.5)'
              ]},
              {
              label: 'Semaine passée',
              data: [4, 10, 5, 3, 7, 2],
              type: 'line'
          }]
      },
      options: {
          barThickness: 'flex',
          gridLines:{
            offsetGridLines: false
          },

          legend: {
          position: 'bottom',
          fullWidth: true,
          labels: {
            fontSize: 14
          }
        },


          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero:true
                  }
              }],

          }
      }
  });


}

}


 export { initChart }
