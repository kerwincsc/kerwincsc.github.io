===========
 Rust 技巧
===========

- 打印胖指针的内部数据

  .. code-block:: rust

     fn main() {
         let arr: [i32; 5] = [1, 2, 3, 4, 5];
         let address: &[i32; 5] = &arr;
         println!("Address of arr: {:p}", address);
         raw_slice(address as &[i32]);
         
     }

     fn raw_slice(arr: &[i32]) {
     
         unsafe {
             let (val1, val2): (usize, usize) = std::mem::transmute(arr);
             println!("Value in raw pointer:");
             println!("value1: {:x}", val1);
             println!("value2: {:x}", val2);
         }
     }

- 查看某类型的占空间大小

  .. code-block:: rust

     std::mem::size_of::<i32>()

- 查看变量的类型信息

  要使用 nightly 版, 是实验性的 API

  .. code-block:: rust

     #![feature(core_intrinsics)]
     fn print_type_name<T>(_arg: &T) {
         unsafe {
             println!("{}", std::intrinsics::type_name::<T>())
         }
     }
     
     fn main() {
         let ref x = 5_i32;
         print_type_name(&x);
     }

- 宏展开

  .. code-block:: rust

     rustc -Z unstable-options --pretty=expanded temp.rs
