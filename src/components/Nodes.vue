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
        <th>Network</th>
        <th>Memory</th>
        <th>Disk Usage</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="node in nodes" :value="node" :key="node.id">
        <td>#{{node.id}}</td>
        <td>{{node.name}}</td>
        <td>
          <span v-if="node.status==-2" class="uk-label uk-label-warning">GFWed</span>
          <span v-if="node.status==1" class="uk-label uk-label-success">OK</span>
        </td>
        <td>{{node.cpu_count}}</td>
        <td><span class="uk-label uk-label-warning">{{node.load1}} {{node.load5}}  {{node.load15}}</span></td>
        <td><span class="uk-label uk-label-success">{{bytesToSize(node.bytesTotal)}}</span></td>
        <td>
          <progress id="js-progressbar" class="uk-progress" :value="node.memoryUsedPercent" max="100"></progress>
        </td>
        <td>
          <progress id="js-progressbar" class="uk-progress" :value="node.disk_usage_percent" max="100"></progress>
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
        if (bytes === 0) return '0 B';
        const k = 1024, // or 1024
          sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
          i = Math.floor(Math.log(bytes) / Math.log(k));
        return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
      },
    },
  }
</script>
