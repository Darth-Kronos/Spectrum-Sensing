# Spectrum-Sensing
## Introduction :


This project aims to use signal processing based features to train and validate machine-learning algorithms to improve spectrum sensing and related problems in cognitive radios. We used differential entropy, geometric power and LP- norm based features to train supervised ML algorithms and various deep neural networks. The noise process is assumed to follow a generalized Gaussian distribution, which is of practical relevance.
Through experimental results based on real-world captured datasets, we show that the proposed method outperforms the energy-based approach in terms of probability of detection. The proposed technique is particularly useful under low signal-to-noise ratio conditions, and when the noise distribution has heavier tails.

## Datasets :

Dataset 1
The centre frequency of the PU was set at 2.48 GHz. The primary transmitter deploys a differential quadrature phase shift keying modulation with a continuous transmission rate of 500 kbps and has a tranmission bandwidth of 1 MHz. The data measurement was carried out in an anechoic chamber with a scan bandwidth of 4 MHz, which uses a discrete Fourier transform of 1024 frequency bins. Therefore, the bandwidth of each frequency bin is 3.9 kHz. To this clean signal, generalized Gaussian noise was added with a given parameter beta and unit variance, which serves as a real-world data that is received by the deployed CR nodes.

Dataset 2 
This dataset was captured in a laboratory in Thailand. The dataset was recorded by an omnidirectional antenna connected to the RF Explorer spectrum analyzer. The operating frequency range is 510 to 790 MHz, with a center frequency of 650 MHz. The measurements were taken in three different locations, with both indoor and outdoor environments. We have used data with the highest signal-to-noise ratio (SNR) for our experimental study.

## System Model :

<img width="814" alt="image" src="https://user-images.githubusercontent.com/44093589/126902793-63074511-a216-49b2-a300-411d419ced60.png">

## Machine Learning Algorithms :

### Classical ML algoirithms :
- Support Vector Machines
-  K-Nearest Neighbor
-  Logistic Regression
-  Random Forest


### Deep net architectures:

<img width="540" alt="image" src="https://user-images.githubusercontent.com/44093589/126903080-b1304c40-92f5-437b-90b9-4c7aa53ea816.png">
<img width="606" alt="image" src="https://user-images.githubusercontent.com/44093589/126903098-ca3e74c1-e3b7-4df6-8c60-41f7ca0c23a9.png">
<img width="422" alt="image" src="https://user-images.githubusercontent.com/44093589/126903630-39572c90-645a-4ac7-b1e4-da91b9ab9a62.png">



## Results:

We show that the combination of features - Differential Entropy, Geometric Power, Lp-Norm and Energy statistic outperforms the performance of raw data. 

<img width="845" alt="image" src="https://user-images.githubusercontent.com/44093589/126903520-7ebf620f-73c7-46f5-a11a-4503c78bdfa2.png">

<img width="505" alt="image" src="https://user-images.githubusercontent.com/44093589/126903754-1305baa7-1025-49ce-8295-f105513678cf.png">

<img width="531" alt="image" src="https://user-images.githubusercontent.com/44093589/126903841-fa6bef53-b30d-45c0-823e-5be0e0981a25.png">
<img width="483" alt="image" src="https://user-images.githubusercontent.com/44093589/126903857-d6dc241b-5d5a-4dd7-bee1-637c5ac396d8.png">

## Publications :
[P. Saravanan, S. S. Chandra, A. Upadhye and S. Gurugopinath, ”A Supervised Learning Approach for Differential Entropy Feature-based Spectrum Sensing,” Proc. International Conference on Wireless Communications, Signal Processing and Networking (WiSPNET), Chennai, India, Mar. 2021.](https://ieeexplore.ieee.org/document/9419447)
  
[A. Upadhye, P. Saravanan, S. S. Chandra and S. Gurugopinath, ”A Survey on Machine Learning Algorithms for Applications in Cognitive Radio Networks,” Proc. International Conference on Electronics, Computing and Communication Technologies(CONECCT), Bengaluru, India, Jul. 2021.](https://ieeexplore.ieee.org/document/9622610)

[S. S. Chandra, A. Upadhye, P. Saravanan, S. Gurugopinath and R. Muralishankar, "Deep Neural Network Architectures for Spectrum Sensing Using Signal Processing Features," Proc. IEEE International Conference on Distributed Computing, VLSI, Electrical Circuits and Robotics (DISCOVER), Nitte, India, Nov. 2021.](https://ieeexplore.ieee.org/document/9663583)

If you use our code and/or system model with proposed features, please cite the above publications.

## Authors :
[Shreeram Suresh Chandra](https://www.linkedin.com/in/shreeram-chandra/)

[Purushothaman Saravanan](https://www.linkedin.com/in/purushothaman-s-yadav/)

[Akshay Upadhye](https://www.linkedin.com/in/akshay-upadhye-44539a157/)
