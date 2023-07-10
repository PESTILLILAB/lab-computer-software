#!/bin/bash

# install mrtrix3
sudo apt-get install git g++ python3 libeigen3-dev zlib1g-dev libqt5opengl5-dev libqt5svg5-dev libgl1-mesa-dev libfftw3-dev libtiff5-dev libpng-dev
git clone https://github.com/MRtrix3/mrtrix3.git
cd mrtrix3
./configure
./build
./set_path
cd ~/

# python packages
python3 -m pip install pip
sudo apt install ipython3
pip3 install numpy nibabel dipy scipy tensorflow pandas scikit-learn dmri-amico dmri-commit nilearn pysurfer pybrainlife pyafq pycortex seaborn

# install docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
groups
sudo usermod -aG docker ${USER}

# install apptainer
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt update
sudo apt install -y apptainer
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt update
sudo apt install -y apptainer-suid

# install freesurfer
curl https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.4.1/freesurfer-linux-ubuntu20_amd64-7.4.1.tar.gz --output ~/freesurfer.tar.gz
tar -zxpf ~/freesurfer.tar.gz
cd ~/freesurfer
echo 'export FREESURFER_HOME=$HOME/freesurfer' >> ~/.bashrc
echo 'source ${FREESURFER_HOME}/SetUpFreeSurfer.sh' >> ~/.bashrc

# install fsl
curl https://fsl.fmrib.ox.ac.uk/fsldownloads/fslconda/releases/fslinstaller.py --output ~/fslinstaller.py
python3 ~/fslinstaller.py

# install connectome workbench
curl https://www.humanconnectome.org/storage/app/media/workbench/workbench-linux64-v1.5.0.zip --output ~/workbench.zip
unzip ~/workbench.zip
echo 'export PATH=$PATH:~/workbench/bin_linux64' >> ~/.bashrc

# set up remote desktop
sudo apt update && sudo apt install xfce4 xfce4-goodies tightvncserver tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer
vncserver
vncserver -kill :* && mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
cat <<EOT >> ~/.vnc/xstartup
#!/bin/bash
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
EOT
chmod +x ~/.vnc/xstartup
vncserver
