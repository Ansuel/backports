@r@
identifier OPS;
identifier bin_attr_read;
fresh identifier bin_attr_read_wrap = "bp_" ## bin_attr_read;
position p;
@@
+#if LINUX_VERSION_IS_LESS(6,14,0)
+static ssize_t bin_attr_read_wrap(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buffer, loff_t pos, size_t count)
+{
+	return bin_attr_read(filp, kobj,
+			    (const struct bin_attribute *)bin_attr,
+			    buffer, pos, count);
+}
+#endif

struct bin_attribute OPS@p = {
+#if LINUX_VERSION_IS_GEQ(6,14,0)
	.read = bin_attr_read,
+#else
+	.read = bin_attr_read_wrap,
+#endif
};
