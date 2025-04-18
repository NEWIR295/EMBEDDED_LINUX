/*
Author: Mohamed Newir
Date: 13/02/2025
File: switch_driver.c
Description:   
            This is a simple Linux kernel module that implements a character device driver for a switch.
            The driver allows user-space applications to read and write the switch state (on/off) through
            read and write operations on the device file.
            The driver uses the Linux kernel's character device API to create a device file
            that can be accessed by user-space applications.
            The switch state is represented as an integer (0 for off, 1 for on).
            The driver provides basic file operations for opening, closing, reading, and writing to the device.
            The switch state can be set by writing '1' or '0' to the device file.
            The current switch state can be read by reading from the device file.
            The driver also includes module initialization and cleanup functions to register and unregister
*/

/*
    Used libraries:
    - linux/module.h: For module initialization and cleanup functions.
    - linux/fs.h: For file operations and character device registration.
    - linux/cdev.h: For character device structure and operations.
    - linux/uaccess.h: For user-space memory access functions.
    - linux/proc_fs.h: For creating proc filesystem entries (not used in this example).
*/
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/uaccess.h>
#include <linux/proc_fs.h>

#define DEVICE_NAME "switch"
static int switch_state = 0;

static dev_t dev;
static struct cdev cdev;
static struct class *class;
/*
    Function: switch_open
    Description: This function is called when the device file is opened.
    It can be used to perform any necessary initialization or setup.
    Parameters:
        - inode: Pointer to the inode structure representing the device file.
        - file: Pointer to the file structure representing the opened file.
*/
static int switch_open(struct inode *inode, struct file *file) { return 0; }
/*
    Function: switch_release
    Description: This function is called when the device file is closed.
    It can be used to perform any necessary cleanup or resource deallocation.
    Parameters:
        - inode: Pointer to the inode structure representing the device file.
        - file: Pointer to the file structure representing the opened file.
*/
static int switch_release(struct inode *inode, struct file *file) { return 0; }
/*
    Function: switch_write
    Description: This function is called when data is written to the device file.
    It updates the switch state based on the input from user-space applications.
    Parameters:
        - file: Pointer to the file structure representing the opened file.
        - buf: Pointer to the buffer containing the data to be written.
        - len: Length of the data to be written.
        - off: Pointer to the offset in the file.
*/
static ssize_t switch_write(struct file *file, const char __user *buf, size_t len, loff_t *off) {
    char kbuf;
    if (len < 1 || copy_from_user(&kbuf, buf, 1)) return -EFAULT;
    switch_state = (kbuf == '1') ? 1 : 0;
    printk(KERN_INFO "Switch set to %d\n", switch_state);
    return len;
}
/*
    Function: switch_read
    Description: This function is called when data is read from the device file.
    It returns the current switch state to user-space applications.
    Parameters:
        - file: Pointer to the file structure representing the opened file.
        - buf: Pointer to the buffer where the data will be read into.
        - len: Length of the data to be read.
        - off: Pointer to the offset in the file.
*/
static ssize_t switch_read(struct file *file, char __user *buf, size_t len, loff_t *off) {
    if (*off != 0) return 0;
    char state = switch_state ? '1' : '0';
    if (copy_to_user(buf, &state, 1)) return -EFAULT;
    *off += 1;
    return 1;
}
/*
    File operations structure
    This structure defines the file operations that can be performed on the device file.
    It includes pointers to the functions for opening, closing, reading, and writing to the device.
    The file operations structure is used by the kernel to route the appropriate function calls
    when user-space applications interact with the device file.
*/
static struct file_operations fops = {
    .open = switch_open,
    .release = switch_release,
    .write = switch_write,
    .read = switch_read,
};
/*
    Function: switch_init
    Description: This function is called when the module is loaded into the kernel.
    It initializes the character device, allocates a device number, and creates the device file.
    Returns:
        - 0 on success, or a negative error code on failure.
*/
static int __init switch_init(void) {
    if (alloc_chrdev_region(&dev, 0, 1, DEVICE_NAME) < 0) return -1;
    cdev_init(&cdev, &fops);
    if (cdev_add(&cdev, dev, 1) < 0) goto err_chrdev;
    class = class_create(DEVICE_NAME);
    if (IS_ERR(class)) goto err_cdev;
    device_create(class, NULL, dev, NULL, DEVICE_NAME);
    printk(KERN_INFO "Switch driver loaded\n");
    return 0;

err_cdev:
    cdev_del(&cdev);
err_chrdev:
    unregister_chrdev_region(dev, 1);
    return -1;
}
/*
    Function: switch_exit
    Description: This function is called when the module is unloaded from the kernel.
    It cleans up resources, unregisters the character device, and removes the device file.
*/
static void __exit switch_exit(void) {
    device_destroy(class, dev);
    class_destroy(class);
    cdev_del(&cdev);
    unregister_chrdev_region(dev, 1);
    printk(KERN_INFO "Switch driver unloaded\n");
}
/*
    Module information
    This section provides information about the module, including its name, author, description,
    and license. It is used by the kernel to identify the module and provide information to users.
*/
MODULE_LICENSE("GPL");
module_init(switch_init);
module_exit(switch_exit);
