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
      <li @click="listClick">test1
        <div v-if="isShow">
          sample
        </div>
      </li>
      <li @click="listClick">test2</li>
      <li @click="listClick">test3</li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "test",
      isShow: false,
      currentList: 
    }
  },
  methods: {
    listClick: function (event) {
      // console.log(event)
      // debugger
      this.title= event.target.firstChild.data
      this.isShow=!this.isShow
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
