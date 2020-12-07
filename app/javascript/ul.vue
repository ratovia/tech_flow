<template>
  <ul class="parent">
    <li v-for="issue in issue_child" class="child" :key="issue.id" @click="listClick" :data-index="issue.id" v-bind:ref="'issue_id_' + issue.id" >
      {{ issue.title }}
      <div v-if="isShow == issue.id" > 
        <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)"></div>
        <parentul
        v-bind:issue_child = "issue.children"
        v-bind:parent_id = "hello('issue_id_' + issue.id)"
        v-bind:child_ids="issue.children.map((child) => {return child.id}) "
        v-bind:issue_id = "issue.id"
        ></parentul>
      </div>
      <p class="link">
      <a v-bind:href="'/flows/' + issue.id + '/edit'" v-if="isShow == issue.id" >編集</a>
      <a v-if="isShow == issue.id" :data-index="issue.id" @click="deleteClick">削除</a>
      </p>
    </li>
    <li class="child" >
      <a v-bind:href="'/flows/new?parent_id=' + this.issue_id">追加</a>
    </li>
  </ul>
</template>

<script>
const axios = require('axios');
export default {
  data: function () {
    return {
      isShow: null,
      lines: [],
      scroll: 0,
      dom: null,
    }
  },
  methods: {
    listClick: function (event) {
      event.stopPropagation()
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

    deleteClick: function (event) {
      window.confirm("削除しますか？【注意】この先のフローも削除されます")
      const index = event.target.dataset.index 
      axios.delete(`/flows/${index}`)
      location.reload(true);
    },

    compiledMarkdown: function(content) {
      return marked(content, { sanitize: true });
    },
    hello: function(ref) {
      return this.$refs[ref]
    },

    calcubottomScroll: function(){
      this.scroll = this.dom.scrollBottom;
    },

    calculateScroll: function(){
      this.scroll = this.dom.scrollLeft;
    }
  },
  
  updated: function() {
    this.lines.map( (line) => { line.position() })
  },

  mounted: function() {
    const array = this.child_ids.map((id) => {return `issue_id_${id}`})
    array.forEach( id => {
      this.lines.push(
        new LeaderLine(
          this.parent_id[0],
          this.$refs[id][0],
          {startSocket: 'right', endSocket: 'left', path: 'grid'}
        )
      )
    })
    this.dom = document.getElementsByClassName("main")[0]
    this.dom.addEventListener('scroll', this.calculateScroll);
    this.dom.addEventListener('scroll', this.calcubottomScroll);
  },
  beforeDestroy: function(){ 
    this.lines.forEach( (line) => { line.remove() })
  },
  props: {
    issue_child: Array,
    parent_id: Array,
    child_ids: Array,
    issue_id: Number
  },
  components: {
    Parentul: () =>  import("./ul.vue")
  },
  
  watch: {
    scroll: function () {
      this.lines.map( (line) => { line.position() })
    },
  }
}
</script>