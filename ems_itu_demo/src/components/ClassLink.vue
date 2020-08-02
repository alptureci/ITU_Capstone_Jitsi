<template>
  <div class="font-size-10pt shadow-4 row items-stretch">
    <div class="column bg-primary text-primary" style="width: 0.5em"></div>
    <q-item
      v-ripple
      clickable
      tag="label"
      class="col no-padding justify-between"
      @click="startVideoChat"
    >
      <q-item-section class="q-px-md q-py-sm">
        <q-item-label lines="1" class="text-uppercase">
          {{ classData.className }} ({{ classData.classDate }})</q-item-label
        >
      </q-item-section>
      <div
        class="bg-primary col-2 column justify-center items-center content-center"
        style="max-width: 5em"
      >
        <q-icon size="xs" name="fas fa-video" color="white"></q-icon>
      </div>
    </q-item>
  </div>
</template>

<script>
export default {
  props: {
    classData: {
      type: Object,
      default: () => {
        return { className: "", classDate: Date.now(), chatLinkURL: "" };
      }
    }
  },
  methods: {
    startVideoChat() {
      window.location = this.classData.chatLinkURL;
    }
  }
};
</script>

<style></style>
