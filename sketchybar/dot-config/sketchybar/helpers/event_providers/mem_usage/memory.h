#include <mach/mach.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

struct memory {
  mach_port_t host_port;
  vm_size_t page_size;

  // Memory info in bytes
  uint64_t total_memory;
  uint64_t free_memory;
  uint64_t cached_memory;
  uint64_t used_memory;
  uint64_t available_memory;

  int usage_percentage;
};

static inline void memory_init(struct memory* mem) {
  mem->host_port = mach_host_self();

  // Get page size
  host_page_size(mem->host_port, &mem->page_size);

  // Get total physical memory
  int mib[2] = {CTL_HW, HW_MEMSIZE};
  size_t length = sizeof(mem->total_memory);
  sysctl(mib, 2, &mem->total_memory, &length, NULL, 0);
}

static inline void memory_update(struct memory* mem) {
  // Get memory statistics
  vm_statistics64_data_t vm_stats;
  mach_msg_type_number_t info_size = HOST_VM_INFO64_COUNT;

  if (host_statistics64(mem->host_port, HOST_VM_INFO64, (host_info64_t)&vm_stats, &info_size) != KERN_SUCCESS) {
    printf("Error: Could not read memory statistics.\n");
    return;
  }

  // Calculate memory metrics exactly as in the provided code
  mem->free_memory = vm_stats.free_count * mem->page_size;
  mem->cached_memory = vm_stats.external_page_count * mem->page_size;
  mem->used_memory = (vm_stats.active_count + vm_stats.wire_count) * mem->page_size;
  mem->available_memory = mem->total_memory - mem->used_memory;

  // Calculate usage percentage
  mem->usage_percentage = ((double)mem->used_memory / (double)mem->total_memory) * 100.0;
}
