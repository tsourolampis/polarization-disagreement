# Minimizing Polarization and Disagreement in Social Networks (WWW 2018)

The rise of social media and online social networks has been a disruptive force in society. Opinions are increasingly shaped by interactions on online social media, and social phenomena including disagreement and polarization are now tightly woven into everyday life.  In our paper [Minimizing Polarization and Disagreement in Social Networks](https://arxiv.org/abs/1712.09948) we initiate the study of the following question:  

>  Given n agents, each with its own initial opinion that reflects its core value on a topic, and an opinion dynamics model, what is the structure of a social network that minimizes  *disagreement* and *polarization* simultaneously?

This question is  central to recommender systems: should a recommender system prefer a link suggestion between two online users with similar mindsets in order to keep disagreement low, or between two users with different opinions in order to expose each to the others viewpoint of the world, and decrease overall levels of polarization and controversy? 

# Matlab code 

The code has been written in Matlab. You need to install [CVX](http://cvxr.com/cvx/) needed for disciplined convex programming, and the [Graph Signal Processing toolbox](https://epfl-lts2.github.io/gspbox-html/) needed for the Spielman-Srivastava effective resistance based sparsification.  This directory contains the following documented Matlab files. 

1. **OptimizeInnate.m** ([see Section 3.3]()): Given a graph represented by the adjacency matrix A, a budget alpha, and a vector of innate opinions s, the code finds a correction vector x with total ell_1 norm at most alpha, that minimizes the sum of disagreement and polarization. 
2. **OptInnate_Demo.m**: A demo file for *OptimizeInnate*.
3. **LearnG.m**: Given a vector of innate opinions represented by a vector s, and a budget W on the total weight of the edges, this function learns the graph that minimizes the polarization-disagreement index in polynomial time. To run it, you need to add CVX to your path. 
4. **demo_LearnG**: A demo file for *LearnG*. Given the number of nodes n, and a set of parameters, this code samples repeatedly a vector of innate opinions s from a distribution specified bythe argument parameters, and runs *LearnG*, and the sparsification procedure of Spielman-Srivastava. The latter requires the  [GSP toolbox](https://epfl-lts2.github.io/gspbox-html/).

 

# Citation

> @inproceedings{muscostsourakakis2018opdyn, 
> title={Minimizing Polarization and Disagreement in Social Networks},
> author={Musco, Cameron, and Musco, Christopher, and Tsourakakis, Charalampos},
> booktitle={{Proceedings of the 27th International conference on World Wide Web (WWW)},
> year={2018},
> organization={ACM}}
