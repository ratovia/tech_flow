<template>
  <ul class="parent">
    <li v-for="issue4 in title" class="child" :key="issue4.id">
      {{ issue4.title }}
      <parentul v-bind:title= "issue4.children"></parentul>
    </li>
  </ul>
</template>

<script>
// import Parentul from "./ul.vue"

export default {

  props: {
    title: Array
  },

  components: {
    Parentul: () =>  import("./ul.vue")
  }

}
</script>