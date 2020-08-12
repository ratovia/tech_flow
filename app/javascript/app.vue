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
      <input v-model="inputData" class="search-bar" type="text" placeholder="検索バー"> <!--　v-modelでデータマインニング　-->
    </div>

    <ul>        
      <li  
        @click="title=issue.title" 
        v-for="issue in filterIssues" 
        :key="issue.id"
      >
        {{ issue.title }}
      </li>

    </ul>
  </div>
</template>


<script>
export default {
  data: function () {
    return {
      title: "test",
      issues: [
        {id: 1, title: "test1"},
        {id: 2, title: "test2"},
        {id: 3, title: "zzzzz"}
      ],
      inputData: ""
    }
  },
  computed: {  
    filterIssues: function () {

      const result = this.issues.filter((issue) => { 
        return issue.title.indexOf(this.inputData) !== -1   
      })
      return result 
    }
  }


}
</script>


<style lang="scss">
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
  
</style>
