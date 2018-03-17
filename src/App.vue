<template>
  <div id="app">


    <div class="uk-container uk-container-center uk-margin-top uk-margin-large-bottom">


      <div class="uk-grid" data-uk-grid-margin>
        <div class="uk-width-1-1">
          <h1 class="uk-heading-large">MonitorUI</h1>

          <Nodes :nodes="nodes"></Nodes>

        </div>
      </div>


    </div>

  </div>


</template>

<script>
  import axios from 'axios'
  import io from 'socket.io-client'
  import Nodes from './components/Nodes.vue'
  import UIkit from 'uikit'

  export default {
    name: 'App',
    data() {
      return {
        api: 'http://127.0.0.1:2008',
        nodes: [],
        ids: {},
      }
    },
    methods: {
      initNodes: function () {
        let t = this;
        axios.get(this.api + '/nodes')
          .then(function (response) {
            t.nodes = response.data;
            for (let i = 0; i < t.nodes.length; i++) {
              t.ids[t.nodes[i].id] = i;
              t.nodes[i].bytesTotal = 0;
            }
          })
          .catch(function (error) {
            UIkit.notification({message: error, status: 'danger'});
            console.log(error);
          });
      },
      initSocket: function () {
        const socket = io(this.api, {
          upgrade: false,
          transports: ['websocket'],
          query: {
            // token: this.token,
          }
        });
        let t = this;
        socket.on('connect', function () {
          UIkit.notification({message: 'Connect to websocket success...', status: 'success'});
          socket.on('serverStat', function (m) {
            let stat = m.Stat;
            let i = t.ids[m.node_id];
            t.nodes[i].bytesTotal = stat.net_speed.bytesRecv + stat.net_speed.bytesSent;
            t.nodes[i].memoryUsedPercent = stat.memory_status.usedPercent;
            t.nodes[i].load1 = stat.avg_load.load1;
            t.nodes[i].load5 = stat.avg_load.load5;
            t.nodes[i].load15 = stat.avg_load.load15;
          })
        });
        socket.on('disconnect', function(){
          UIkit.notification({message: "websocket disconnect...", status: 'danger'});
        });
      }
    },

    mounted: function () {
      this.initNodes();
      this.initSocket();
    },
    components: {
      Nodes,
    }
  }
</script>

