<template>
  <div id="app">
    <webview id="foo" src="https://admin:2222@tech-flow.herokuapp.com/"></webview>
    <!-- <webview id="foo" src="https://admin:2222@localhost:3000/"></webview> -->
  </div>
</template>

<script>

export default {
  name: 'App',
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
