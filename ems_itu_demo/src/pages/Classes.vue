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
const dateTimeFormat = new Intl.DateTimeFormat("en", {
  year: "numeric",
  month: "short",
  day: "2-digit",
  hour: "numeric",
  minute: "numeric",
  second: "numeric",
  hour12: false
});
import ClassLink from "../components/ClassLink.vue";
export default {
  name: "PageIndex",
  components: { ClassLink },
  data() {
    return {
      classes: [
        {
          className: "Ethical Hacking",
          classDate: this.formatDate(new Date())
        },
        {
          className: "Software Architecture",
          classDate: this.formatDate(new Date())
        },
        {
          className: "Software Requirements Elicitation",
          classDate: this.formatDate(new Date())
        },
        {
          className: "Advanced Software Engineering",
          classDate: this.formatDate(new Date())
        },
        {
          className: "Software Engineering",
          classDate: this.formatDate(new Date())
        },
        {
          className: "Cybersecurity Fundamentals",
          classDate: this.formatDate(new Date())
        }
      ]
    };
  },
  methods: {
    formatDate(date) {
      return dateTimeFormat.format(date);
    }
  }
};
</script>
