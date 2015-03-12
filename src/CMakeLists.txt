# file with main in it
set(MAIN_SRC
  main.cc)

# rest of .cc's
set(SRCS
  )

# if we use gtest unittesting
#set(UNITTEST_SRCS
#  test_main.cc)

# # gflags
# find_package (gflags REQUIRED)
# include_directories(${INCLUDE_DIR}/gflags)

#if we need boost, and what libraries
#find_package(Boost 1.57.0 COMPONENTS filesystem system REQUIRED)
#if(Boost_FOUND)
#  include_directories(${Boost_INCLUDE_DIRS})
#endif()

#if(APPLE)
## if OS X, find these packages
## none
#else()
#  # if not OS X, find these packages
#  find_package(Curses)
#  if(CURSES_FOUND)
#    # if you find it, include its' headers
#    include_directories(${CURSES_INCLUDE_DIR})
#  endif()
#endif()

## tell find_package where it can find readline
#set(Readline_DIR ${INCLUDES_DIR})
#find_package(Readline)
#if(READLINE_FOUND)
#  # if you find it, define READLINE
#  add_definitions(-DREADLINE)
#    # if you find it, include its' headers
#  include_directories(${Readline_INCLUDE_DIR})
#endif()

# includes
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

#binary names
set(RELEASE_BINARY "${PROJECT_NAME}")
set(UNITTEST_BINARY "${PROJECT_NAME}-test")

add_executable(${RELEASE_BINARY} ${MAIN_SRC} ${SRCS})

#use C++11
set_property(TARGET ${RELEASE_BINARY} PROPERTY CXX_STANDARD 11)
#C++11 required
set_property(TARGET ${RELEASE_BINARY} PROPERTY CXX_STANDARD_REQUIRED ON)

# #use C++14
# set_property(TARGET ${RELEASE_BINARY} PROPERTY CXX_STANDARD 14)
# #C++14 required
# #set_property(TARGET ${RELEASE_BINARY} PROPERTY CXX_STANDARD_REQUIRED ON)

# # # link libraries
# target_link_libraries(${RELEASE_BINARY} gflags)

# # if curses was found, link binary with boost, readline and curses
# if(CURSES_FOUND)
#   target_link_libraries(${RELEASE_BINARY} ${Boost_LIBRARIES}  ${Readline_LIBRARY} ${CURSES_LIBRARIES})
# # if curses was not found, but readline was, link binary with boost and readline
# elseif(READLINE_FOUND)
#   target_link_libraries(${RELEASE_BINARY} ${Boost_LIBRARIES}  ${Readline_LIBRARY})
# else()
#   # finally, if only boost is found, link only boost
#   target_link_libraries(${RELEASE_BINARY} ${Boost_LIBRARIES})
# endif()

# # Unit Testing with gtest
# if (test)
#   enable_testing()

#   # Unit Tests
# 	add_executable(${UNITTEST_BINARY} ${UNITTEST_SRCS})

#   # Standard linking to gtest stuff.
#   # also link boost
# 	target_link_libraries(${UNITTEST_BINARY} ${Boost_LIBRARIES} gtest gtest_main)

#   # This is so you can do 'make test' to see all your tests run, instead of
#   # manually running the executable runUnitTests to see those specific tests.
#   add_test(NAME that-test-I-made COMMAND ${UNITTEST_BINARY})

#   # You can also omit NAME and COMMAND. The second argument could be some other
#   # test executable.
#   add_test(that-other-test-I-made ${UNITTEST_BINARY})
# endif()