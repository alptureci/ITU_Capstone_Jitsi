<template>
  <q-page class="flex justify-start q-pa-lg">
    <div class="column q-gutter-md" style="width:30%">
      <q-item-label class="text-h5 text-secondary q-pb-lg"
        >Incoming class list</q-item-label
      >
      <class-link
        v-for="(itu_class, index) in classes"
        :key="index"
        :class-data="itu_class"
      ></class-link>
    </div>
  </q-page>
</template>

<script>
import ClassLink from "../components/ClassLink.vue";
export default {
  name: "PageIndex",
  components: { ClassLink },
  data() {
    return {
      classes: []
    };
  },
  async mounted() {
    try {
      let classes = await this.$axios.get("http://localhost:3000/classes");
      this.classes = classes.data;
      console.log("Classes", classes.data);
    } catch (error) {
      this.$q.notify({
        color: "negative",
        position: "top",
        message: error,
        icon: "report_problem"
      });
    }
  }
};
</script>
