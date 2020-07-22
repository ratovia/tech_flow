<template>
  <div id="app">
    <header>
      <h1 class="logo">
        TECH FLOW
      </h1>
      <div class="title">
        {{title}}
      </div>
    </header>
    <ul>
      <li @click="title= 'test1'">test1</li>
      <li @click="title= 'test2'">test2</li>
      <li @click="title= 'test3'">test3</li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "test"
    }
  }
}
</script>

<style lang="scss">
  header {
    height: 100px;
    width: 100vw;
    background-color: rgb(77, 70, 70);
    display: flex;
    position: relative;
    padding: 0px 20px;
    .logo {
      color: rgb(42, 218, 174);
      font-size: 22px;
      font-weight: bold;
      line-height: 100px;
    }
    .title {
      color: white;
      font-size: 18px;
      font-weight: bold;
      line-height: 100px;
      width: 100vw;
      text-align: center;
      position:absolute;
      left: 0;
    }
  }
</style>
