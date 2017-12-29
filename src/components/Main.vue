<template>
  <div id="main">
    <div id="search-header">
      <h2>PyPI Popular</h2>
      <div id="search-bar">
        <icon name="search"></icon>
        <input name="search">
      </div>
    </div>
    <div id="search-container">
      <div id="search-filters">
        <div>
        </div>
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

#search-header {
  width: 100%;
  background-color: #F1F1F1;
  height: 40px;
  display: flex;
  padding: 10px 10px 10px 10px;
}

#search-header h2 {
  display: inline-block;
  width: 190px;
  margin: auto;
  color: #234764;
}

#search-header svg {
  color: #234764;
  margin-left: 15px;
  margin-top: 10px;
}

#search-header input {
  height: 30px;
  border-radius: 5px;
  font-size: 16pt;
  border: none;
  background: none;
  flex: 1 100%;
  height: 100%;
  margin-left: 15px;
}

#search-bar {
  border: 1px solid #CCCCCC;
  background-color: white;
  flex: 1 100%;
  display: flex;
  margin: 0px 30px;
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
