import sys
from rosbag import Bag


def RenameTopics(bag_file,location, collect_type, car_name):
    print("Renaming topics...") 
    new_bag_file = bag_file + "_" + location + "_" + collect_type + "_" + car_name +".bag" 

    velodyne_name  = '/vlp16_1/velodyne_points'
    new_velodyne_name = '/points_raw'
    
    with Bag(new_bag_file, 'w') as Y:
        for topic, msg, t in Bag(bag_file+".bag"):
            if topic == velodyne_name:
                Y.write(new_velodyne_name, msg , t)
            else:
                Y.write(topic, msg, t)

if __name__ == "__main__":
    RenameTopics(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])
