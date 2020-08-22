<template>
  <ul class="parent">
    <li v-for="issue in issue_child" class="child" :key="issue.id" @click="listClick" :data-index="issue.id">
      {{ issue.title }}
      <div v-if="isShow == issue.id" > 
        {{issue.content}}
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