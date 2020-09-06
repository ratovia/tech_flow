<template>
  <ul class="parent">
    <li v-for="issue in issue_child" class="child" :key="issue.id" @click="listClick" :data-index="issue.id">
      {{ issue.title }}
      <div v-if="isShow == issue.id" > 
        <div class="markdown-body issue-detail" v-html="compiledMarkdown(issue.content)"></div>
        <parentul v-bind:issue_child= "issue.children"></parentul>
      </div>
    </li>
  </ul>
</template>

<script>
export default {
  data: function () {
    return {
      isShow: null,
    }
  },
  methods: {
    listClick: function (event) {
      event.stopPropagation()
      const index = event.target.dataset.index 
      this.isShow = index 
      if (index){ 
        this.title = event.target.firstChild.data 
      } else{
        this.title = "test"
      }
    },

    compiledMarkdown: function(content) {
      return marked(content, { sanitize: true });
    }
  },
  props: {
    issue_child: Array
  },
  components: {
    Parentul: () =>  import("./ul.vue")
  },
}
</script>