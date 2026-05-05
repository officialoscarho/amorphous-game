if (variable_instance_exists(id, "cam")) {
    if (cam != -1) {
        camera_destroy(cam);
        cam = -1;
    }
}
