<template>
  <div class="app" id="app">
    <div class="search-field">
      <input v-model="inputData" class="search-bar" type="text" placeholder="検索バー" @input="search">
    </div>
    <div class="main">
      <ul class="parent">
        <li class="child" v-for="issue in filterIssues" :key="issue.id" @click="listClick" :data-index="issue.id" v-bind:ref="'issue_id_' + issue.id">
          {{ issue.title }}
          <div v-if="isShow == issue.id" > 
            <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)" @click="back">
            </div>
            <span @click="back" id="back">前に戻る</span>
            <parentul 
            v-bind:issue_child = "issue.children" 
            v-bind:parent_id = "hello('issue_id_' + issue.id)" 
            v-bind:child_ids="issue.children.map((child) => {return child.id}) "
            v-bind:issue_id = "issue.id"
            ></parentul>
          </div>
          <p class="link">
          <a v-bind:href="'/flows/' + issue.id + '/edit'" v-if="isShow == issue.id" >編集</a>
          <a v-bind:href="'/flows/' + issue.id " v-if="isShow == issue.id" data-method="delete" data-confirm="削除しますか？【注意】この先のフローも削除されます" >削除</a>
          </p>
        </li>
        <li class="child">
          <a href="/flows/new" >追加</a>
        </li>
      </ul>
    </div>
    <div class="logo">
        <h1 class="logo-title">
          TECH FLOW
        </h1>
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
      return this.issues
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
    },
    search: function(){
      const input = this.inputData;
      axios.get('/api/v1/issues/search',{
        params: {
          keyword: input
        }
      })
      .then( response => {
        this.issues = response.data
      })
    },
    back: function(){
      let num = this.isShow
      axios.get('/api/v1/issues/get_parent',{
        params: {
          keyword: num
        }
      })
      .then( response => {
        this.issues = response.data
      })
    },
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
  .app{
    background-color: black;
  }
  .logo{
    position: relative;
  }
  .logo-title{
      color: rgb(42, 218, 174);
      font-size: 20px;
      font-weight: bold;
      line-height: 100px;
      position: fixed;
      right: 0;
      bottom: 0;
      margin-right: 40px;
  }
  .search-field{
    height: 100px;
    width: 100vw;
    display:flex;
    justify-content: center;
    align-items: center;
    background-color: black;
    z-index: 20;
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
    height: calc(100vh - 000px );
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
        font-size: 0.8em;
      }
      #back{
        color:black;
        font-size: 0.8em;
      }
    }
    .link {
      display: flex;
      justify-content: space-around;
    }
    a {
      text-decoration: none;
      color: white;
    }
  }
</style>