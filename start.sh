#!/bin/bash

bin/rake jobs:work >> log/delayed_jobs.log 2>&1 &

bin/rails server -b 0.0.0.0