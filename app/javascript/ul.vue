<template>
  <ul class="parent">
    <li v-for="issue in issue_child" class="child" :key="issue.id" @click="listClick" :data-index="issue.id" v-bind:ref="'issue_id_' + issue.id" >
      {{ issue.title }}
      <div v-if="isShow == issue.id" > 
        <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)"></div>
        <parentul
        v-on:addIssues = "fetchIssues"
        v-bind:issue_child = "issue.children"
        v-bind:parent_id = "hello('issue_id_' + issue.id)"
        v-bind:ancestry = "issue.id"
        v-bind:child_ids="issue.children.map((child) => {return child.id}) "></parentul>
      </div>
    </li>
    <li class="child" @click="changeDisplay">
      追加
      <div class="new_issue_box" :style="{display: showDisplay}">
        <form v-on:submit.prevent="addIssue" class="issue_form">
          <input v-model="newTitle" placeholder="title" class="child" >
          <textarea v-model="content" placeholder="入力してください（Markdown記法使えます）" class="content_box"></textarea>
          <button type="submit" name="button" >追加</button>
        </form>
      </div>
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
      showDisplay: "none",
      newTitle: "",
      content: "",
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
    },

    changeDisplay: function () {
      if (this.showDisplay == "none") {
        this.showDisplay = "block"
      }
    },

    addLeadeLine: function () {
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
    },

    addIssue: function () {
      axios.post('/api/v1/issues', {
        title: this.newTitle,
        content: this.content,
        parent_id: this.ancestry,
      })
      .then( response => {
        // this.child_ids = [...this.child_ids, response.data.pop().id]
        // this.$forceUpdate
        this.addLeadeLine()
        this.$emit('addIssues')
        this.newTitle = ""
        this.content = ""
        this.showDisplay = "none"
      })
    }

  },

  updated: function() {
    this.lines.map( (line) => { line.position() })
  },

  mounted: function() {
    this.addLeadeLine()
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
    ancestry: Number,
    child_ids: Array
  },
  components: {
    Parentul: () =>  import("./ul.vue")
  },

  watch: {
    scroll: function () {
      this.lines.map( (line) => { line.position() })
      // this.test()
    },
  }
}
</script>