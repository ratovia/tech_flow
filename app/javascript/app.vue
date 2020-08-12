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
    <div class="main">
      <ul class="parent">
        <li class="child" @click="listClick" data-index=1>
          test1
          <div v-if="isShow == 1" > 
            1の内容
          </div>
          <ul class="parent">
            <li class="child">
              child
              <ul class="parent">
                <li class="child">
                  grand_child
                  <ul class="parent">
                    <li class="child">
                      2grand_child
                      <ul class="parent">
                        <li class="child">
                          3grand_child
                        </li>
                        <li class="child">
                          3grand_child
                        </li>
                        <li class="child">
                          3grand_child
                        </li>
                        <li class="child">
                          3grand_child
                        </li>
                        <li class="child">
                          3grand_child
                        </li>
                      </ul>
                    </li>
                    <li class="child">
                      2grand_child
                    </li>
                    <li class="child">
                      2grand_child
                    </li>
                  </ul>
                </li>
                <li class="child">grand_child</li>
                <li class="child">grand_child</li>
              </ul>
            </li>
            <li class="child">child</li>
            <li class="child">child</li>
            <li class="child">child</li>
            <li class="child">child</li>
          </ul>
        </li>
        <li class="child" @click="listClick" data-index=2>
          test2
          <div v-if="isShow == 2">
            2の内容
          </div>
        </li>
        <li class="child" @click="listClick" data-index=3>
          test3
          <div v-if="isShow == 3">
            3の内容
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
const axios = require('axios');

export default {
  data: function () {
    return {
      title: "test",
      isShow: null,
      issues: [],
      height: ""
    }
  },
  methods: {
    listClick: function (event) {
      const index = event.target.dataset.index 
      this.isShow = index 
      if (index){ 
        this.title = event.target.firstChild.data 
      } else{
        return false 
      }
    }
  },

  mounted: function () {
    axios.get('/api/v1/issues')
      .then( response => {
        this.issues = response.data
      })
      
  }
}
</script>

<style lang="scss">
  * {
  box-sizing: border-box;
  }

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

  .main {
    width: 100vw;
    height: calc(100vh - 100px );
    overflow-x: scroll;
    .parent{
      width: 310px;
      padding: 30px;
      position: relative;
      ul {
        position: absolute;
        left: 310px;
        top: 0px;
      }
    }
    .child {
      width: 250px;
      min-height: 50px;
      line-height: 30px;
      background-color: red;
      padding: 10px;
      margin-bottom: 20px;
      overflow: scroll;
      div {
        background-color:lightcoral;
        height:50px;
      }
    }
  }
</style>
