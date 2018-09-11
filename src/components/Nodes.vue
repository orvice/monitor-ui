<template>
  <div>
    <table class="uk-table uk-table-hover uk-table-divider">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Status</th>
        <th>Cpu</th>
        <th>Load</th>
        <th>Traffic ↑|↓</th>
        <th>Network ↑|↓</th>
        <th>CPU Usage</th>
        <th>Memory</th>
        <th>Disk Usage</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="node in nodes" :value="node" :key="node.id">
        <td>#{{node.id}}</td>
        <td>{{node.name}}</td>
        <td>
          <span v-if="node.status===-2" class="uk-label uk-label-warning">GFW</span>
          <span v-else-if="node.status===1" class="uk-label uk-label-success">OK</span>
          <span v-else class="uk-label uk-label-danger">Unknown</span>
        </td>
        <td>{{node.cpu_count}}</td>
        <td><span class="uk-label uk-label-warning">{{node.load1}} {{node.load5}}  {{node.load15}}</span></td>
        <td>
          <span class="uk-label uk-label-primary">{{bytesToSize(node.bytesSentTotal)}}</span> |  <span class="uk-label uk-label-success">{{bytesToSize(node.bytesRecvTotal)}}</span>
        </td>
        <td>
          <span class="uk-label uk-label-primary">{{bytesToSize(node.bytesSent)}}</span> |  <span class="uk-label uk-label-success">{{bytesToSize(node.bytesRecv)}}</span>
        </td>

        <td>
          <progress v-if="node.cpu_percent<80" id="js-progressbar" class="uk-progress uk-progress-success"
                    :value="node.cpu_percent" max="100"></progress>
          <progress v-if="node.cpu_percent>=80" id="js-progressbar" class="uk-progress uk-progress-warning"
                    :value="node.cpu_percent" max="100"></progress>
        </td>

        <td>
          <progress v-if="node.memoryUsedPercent<80" id="js-progressbar" class="uk-progress uk-progress-success"
                    :value="node.memoryUsedPercent" max="100"></progress>
          <progress v-if="node.memoryUsedPercent>=80" id="js-progressbar" class="uk-progress uk-progress-warning"
                    :value="node.memoryUsedPercent" max="100"></progress>
        </td>

        <td>
          <progress id="js-progressbar" class="uk-progress" :value="node.disk_usage_percent" max="100">
            {{node.disk_usage_percent}}%
          </progress>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'nodes-page',
    props: ['nodes'],
    methods: {
      bytesToSize: function (bytes) {
        if (bytes === undefined){
          return '0 B';
        }
        if (bytes === 0) return '0 B';
        const k = 1024, // or 1024
          sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
          i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
      },
    },
  }
</script>

<style>

</style>
