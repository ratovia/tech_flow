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
        <li class="child" v-for="issue in filterIssues" :key="issue.id" @click="listClick" :data-index="issue.id" v-bind:ref="'issue_id_' + issue.id">
          {{ issue.title }}
          <div v-if="isShow == issue.id" > 
            <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)"></div>
            <parentul 
            v-bind:issue_child = "issue.children" 
            v-bind:parent_id = "hello('issue_id_' + issue.id)" 
            v-bind:child_ids="issue.children.map((child) => {return child.id}) "></parentul>
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
      inputData: "",
      isShow: null,
      issues: [],
    }
  },
  computed: {  
    filterIssues: function () {
      const result = this.issues.filter((issue) => {
        return issue.title.indexOf(this.inputData) !== -1
      })
      return result 
    }
  },
  methods: {
    listClick: function (event) {
      const index = event.target.dataset.index 
      if (this.isShow == index) { 
        this.isShow = null
      } else if (index) {
        this.isShow = index 
        this.title = event.target.firstChild.data 
      } else{
        this.title = "test"
      }
    },
    hello: function(ref) {
      return this.$refs[ref]
    },
    compiledMarkdown: function(content) {
      return marked(content, { sanitize: true });
    }
  },
  mounted: function () {
    axios.get('/api/v1/issues')
      .then( response => {
        this.issues = response.data
      })
  },
  components: {
    Parentul: () =>  import("./ul.vue")
  },
}
</script>

<style lang="scss">
  * {
    box-sizing: border-box;
  }
  .leader-line{
    z-index:2;
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
    background-color: black;
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
    background-color:black;
    .parent{
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
      min-height: 45px;
      line-height: 30px;
      background-color: #f17d5a;
      color: white;
      padding: 8px 0px 0px;
      margin-bottom: 20px;
      overflow: auto;
      text-align: center;
      div {
        background-color:#fdfdff;
        min-height: 200px;
        border: 1px solid lightgray
      }
      .issue-detail {
        padding: 5px;
        text-align: start;
        font-size: 0.5em;
      }
    }
  }
</style>