/*
Author: Mohamed Newir
Date: 13/02/2025
File: led_driver.c
Description:   
            This is a simple Linux kernel module that implements a character device driver for a LED.
            The driver allows user-space applications to control the LED state (on/off) through
            read and write operations on the device file.
            The driver uses the Linux kernel's character device API to create a device file
            that can be accessed by user-space applications.
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


#define DEVICE_NAME "led"
static int led_state = 0;

static dev_t dev;
static struct cdev cdev;
static struct class *class;
/*
    Function: led_open
    Description: This function is called when the device file is opened.
    It can be used to perform any necessary initialization or setup.
    Parameters:
        - inode: Pointer to the inode structure representing the device file.
        - file: Pointer to the file structure representing the opened file.
*/
static int led_open(struct inode *inode, struct file *file) { return 0; }
/*
    Function: led_release
    Description: This function is called when the device file is closed.
    It can be used to perform any necessary cleanup or resource deallocation.
    Parameters:
        - inode: Pointer to the inode structure representing the device file.
        - file: Pointer to the file structure representing the opened file.
*/
static int led_release(struct inode *inode, struct file *file) { return 0; }
/*
    Function: led_write
    Description: This function is called when data is written to the device file.
    It updates the LED state based on the input from user-space applications.
    Parameters:
        - file: Pointer to the file structure representing the opened file.
        - buf: Pointer to the buffer containing the data to be written.
        - len: Length of the data to be written.
        - off: Pointer to the offset in the file.
*/
static ssize_t led_write(struct file *file, const char __user *buf, size_t len, loff_t *off) {
    char kbuf;
    if (len < 1 || copy_from_user(&kbuf, buf, 1)) return -EFAULT;
    led_state = (kbuf == '1') ? 1 : 0;
    printk(KERN_INFO "LED set to %d\n", led_state);
    return len;
}
/*
    Function: led_read
    Description: This function is called when data is read from the device file.
    It returns the current LED state to user-space applications.
    Parameters:
        - file: Pointer to the file structure representing the opened file.
        - buf: Pointer to the buffer where the data will be read into.
        - len: Length of the data to be read.
        - off: Pointer to the offset in the file.
*/
static ssize_t led_read(struct file *file, char __user *buf, size_t len, loff_t *off) {
    if (*off != 0) return 0;
    char state = led_state ? '1' : '0';
    if (copy_to_user(buf, &state, 1)) return -EFAULT;
    *off += 1;
    return 1;
}
/*
    File operations structure
    Description: This structure defines the file operations for the LED device driver.
    It specifies the functions to be called for open, release, write, and read operations.
    The functions are defined above and are used to handle the corresponding operations.
*/
static struct file_operations fops = {
    .open = led_open,
    .release = led_release,
    .write = led_write,
    .read = led_read,
};
/*
    Function: led_init
    Description: This function is called when the module is loaded into the kernel.
    It registers the character device, creates the device file, and initializes the LED state.
    Returns:
        - 0 on success, or a negative error code on failure.
*/
static int __init led_init(void) {
    if (alloc_chrdev_region(&dev, 0, 1, DEVICE_NAME) < 0) return -1;
    cdev_init(&cdev, &fops);
    if (cdev_add(&cdev, dev, 1) < 0) goto err_chrdev;
    class = class_create(DEVICE_NAME);
    if (IS_ERR(class)) goto err_cdev;
    device_create(class, NULL, dev, NULL, DEVICE_NAME);
    printk(KERN_INFO "LED driver loaded\n");
    return 0;

err_cdev:
    cdev_del(&cdev);
err_chrdev:
    unregister_chrdev_region(dev, 1);
    return -1;
}
/*
    Function: led_exit
    Description: This function is called when the module is unloaded from the kernel.
    It cleans up resources, unregisters the character device, and removes the device file.
*/
static void __exit led_exit(void) {
    device_destroy(class, dev);
    class_destroy(class);
    cdev_del(&cdev);
    unregister_chrdev_region(dev, 1);
    printk(KERN_INFO "LED driver unloaded\n");
}
/*
    Module information
    Description: This section provides information about the module, including its name,
    author, description, and license. It also specifies the initialization and exit functions.
*/
MODULE_LICENSE("GPL");
module_init(led_init);
module_exit(led_exit);
