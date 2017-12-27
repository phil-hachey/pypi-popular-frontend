<template>
  <div id="main">
    <div id="search-bar">
      <h2>PyPI Popular</h2>
      <input name="search">
    </div>
    <div id="search-container">
      <div id="search-filters">

      </div>
      <div id="package-list">
        <div v-for="pack in packages" class="package-tile">
          <div class="package-title">
            <span>{{pack.name}} - {{pack.current_version}}</span>
          </div>
          <div class="package-details">
            <div>
              <span>Author: {{pack.author}}</span>
            </div>
            <div>
              <span>Total downloads: {{pack.total_downloads}}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Main',
  created () {
    this.packages = [];
    this.$http.get('static/data.json')
      .then(response => {
        this.packages = response.body;
        this.$forceUpdate();
      });
  }
}
</script>

<style>
#main {

}

#search-bar {
  width: 100%;
  background-color: #F1F1F1;
  height: 40px;
  display: inline-block;
  padding: 10px 10px 10px 10px;
}

#search-bar h2 {
  display: inline-block;
  width: auto;
  margin: 0;
  margin-right: 20px;
  color: #234764;
}

#search-bar input {
  width: 600px;
  height: 30px;
  border: 1px solid #CCCCCC;
  border-radius: 5px;
  font-size: 16pt;
}

#search-container {
  display: flex;
  flex-direction: row;
}

#search-filters {
  width: 400px;
  height: 100px;
}

#package-list {
  flex: 1 100%;
  margin: 10px;
  max-width: 800px;
}

.package-tile {
  border: 1px solid #6D6D6D;
  margin-bottom: 20px;
  border-radius: 3px;
}

.package-title {
  padding: 6px;
  background-color: #CCCCCC;
  color: #234764;
}

.package-details {
  padding: 6px;
  background-color: #EFEFEF
}

/*
  blue #376A94
  lightyellow: #f7f6f0
  strong yellow: #FFBC29
  light grey: #F1F1F1
  dark grey: #CCCCCC
  medium grey: #EFEFEF
  font color: #234764
*/

</style>
