To activate this project's virtualenv, run 
pipenv shell

python classify_image.py --image images/bmw.png --model densenet
python classify_image.py --image images/jemma.png --model resnet
python classify_image.py --image images/soccer_ball.jpg --model inception