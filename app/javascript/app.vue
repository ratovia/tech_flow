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
    <div class="search-field">
      <input v-model="inputData" class="search-bar" type="text" placeholder="検索バー">
    </div>
    <div class="main">
      <ul class="parent">
        <li class="child" v-for="issue in issues,filterIssues" :key="issue.id" @click="listClick" :data-index="issue.id"> 
          {{issue.title}}
          <div v-if="isShow == issue.id" > 
            {{issue.content}}
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
      inputData: "",
      isShow: null,
      issues: [],
    }
  },
  computed: {  
    filterIssues: function () {
      const result = this.issues.filter((issue) => { 
        console.log(result)
        return issue.title.indexOf(this.inputData) !== -1   
      })
      return result 
    }
  },
  methods: {
    listClick: function (event) {
      const index = event.target.dataset.index 
      this.isShow = index 
      if (index){ 
        this.title = event.target.firstChild.data 
      } else{
        this.title = "test"
      }
    }
  },
  mounted: function () {
    axios.get('/api/v1/issues')
      .then( response => {
        this.issues = response.data
      } 
      )
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
  .search-field{
    height: 100px;
    width: 100vw;
    display:flex;
    justify-content: center;
    align-items: center;
    .search-bar{
      width: 50%;
      padding: 5px 10px;
      border: none;
      border-bottom: 1px solid ;
      outline: none;
      transition: all 0.3s;
      &:focus{
        width: 60%;
        padding: 6px 12px;
        font-size: 22px;
      }
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
      }
    }
  }
</style>