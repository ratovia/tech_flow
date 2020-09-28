<template>
  <ul class="parent">
    <li v-for="issue in issue_child" class="child" :key="issue.id" @click="listClick" :data-index="issue.id" v-bind:ref="'issue_id_' + issue.id" >
      {{ issue.title }}
      <div v-if="isShow == issue.id" > 
        <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)"></div>
        <parentul v-bind:issue_child = "issue.children" v-bind:parent_id = "hello('issue_id_' + issue.id)" v-bind:child_ids="issue.children.map((child) => {return child.id}) "></parentul>
      </div>
    </li>
  </ul>
</template>

<script>
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
    child_ids: Array
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