<script setup>
  import { ref } from 'vue'
  
  let loginForm = ref({username:'', password:''})
  
</script>

<template>
  <div id="container">
    
  </div>
</template>

<style scoped>
#container {
  padding: 10%;
  height: 630px;
  background-image: url('@/assets/images/index.jpg');
  background-repeat: no-repeat;
  background-size: cover;
}

</style>