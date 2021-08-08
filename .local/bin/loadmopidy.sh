#!/bin/bash

while [ $? = 1 ]; do mpc; done &&
mpc load Thing &&
mpc random on
