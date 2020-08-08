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
    <ul>
      <li @click="listClick" data-index=1 value="test1">test1
        <!-- v-if="条件"と書くことで条件の真偽によりその要素を表示するかしないかをコントロールできる -->
        <!-- ↓isShowが1のときに表示される -->
        <div v-if="isShow == 1" > 
          1の内容
        </div>
      </li>
      <br>
      <li @click="listClick" data-index=2 value="test2">test2
        <!-- ↓isShowが2のときに表示される -->
        <div v-if="isShow == 2">
          2の内容
        </div>
      </li>
      <br>
      <li @click="listClick" data-index=3 value="test3">test3
        <!-- ↓isShowが3のときに表示される -->
        <div v-if="isShow == 3">
          3の内容
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "test",
      isShow: null,
    }
  },
  methods: {
    listClick: function (event) {
      // console.log(event.target)
      const index = event.target.dataset.index //押した項目（event.tatget）のdivタグに付与しているカスタムデータを取得
      this.isShow = index //isShowにindexを代入
      if (index){ 
        this.title = event.target.firstChild.data //titleをthisのtitleに書き換え
      } else{
        return false //clickした要素にindexがない場合=中身をクリックした時はtextを取得しない
      }
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
</style>
