%% Etude du pendule inversé
%
clear all;
%
%% Configuration de la maquette
%% Configuration du SRV02
% Configuration des engrenages: choisir 'HIGH' ou 'LOW'
EXT_GEAR_CONFIG = 'HIGH';
% Type du codeur: choisir 'E' ou 'EHR'
ENCODER_TYPE = 'E';
% Le SRV02 est-il équipé d'un tachymètre?: choisir 'YES' ou 'NO'
TACH_OPTION = 'NO';
% Type de charge: choisir 'NONE', 'DISC', ou 'BAR'
LOAD_TYPE = 'ROTPEN';
% Gain d'amplificateur utilisé: 
% VoltPAQ-X2 choisir K_AMP à 3
% Sinon à 1
K_AMP = 1;
% Type d'amplificateur utilisé : définir soit 'VoltPAQ', 'UPM_1503', 'UPM_2405', or 'Q3'
AMP_TYPE = 'UPM_1503';
%
%% Génération des paramètres
% Calacul des paramètres du moteur en fonction des options choisis
[ Rm, kt, km, Kg, eta_g, Beq, Jm, Jeq, eta_m, K_POT, K_TACH, K_ENC, VMAX_AMP, IMAX_AMP ] = config_srv02( EXT_GEAR_CONFIG, ENCODER_TYPE, TACH_OPTION, AMP_TYPE, LOAD_TYPE );
% Charge les paramètres du bras
[ g, Mr, Lr, lr, Jr, Dr ] = config_sp( 'ROTARY_ARM', 'ROTPEN-E' );
% Charge les paramètres du pendule
[ g, Mp, Lp, lp, Jp, Dp ] = config_sp( 'MEDIUM_12IN', 'ROTPEN-E' );
%
%% Réglage de Te et de l'initialisation
    Te=0.02;
    Theta_init=25;
    Alpha_init_nl=0.06;%Origine en haut
    Alpha_init_sup=3;%Origine en haut
    Alpha_init_inf=0;%Origine en bas
%
%% Appel des fichiers
    
Espace_etat_ABCD; % A COMPLETER génère {A,B,C,D}{up,int,down}
    
systeme_haut = ss(Aup,Bup,Cup,Dup)

poles_de_Aup = eig(Aup) %1ere question
commandablite_de_haut = ctrb(Aup,Bup) %2eme question
rang_com_haut = rank(commandablite_de_haut)%2eme question
observabilite_de_haut = obsv(Aup,Cup)%3eme question
rang_obs_haut = rank(observabilite_de_haut)%3eme question


    
%     comup=rank(ctrb(Aup,Bup))
%     comdown=rank(ctrb(Adown,Bdown))
%     
%     obsup=rank(obsv(Aup,Cup))
%     obsdown=rank(obsv(Adown,Cdown))
%     acker(Aup,Bup,[-108 -0.3 -4.3+2.2*i -4.3-2.2*i])
%     eig(Aup-Bup*k)
    
    Pseudo_derivateur; % NE PAS MODIFIER
    Commande_point_haut; % A COMPLETER POUR GENERER Kup, Kint et Ki, Kswing

%% Simulations / Réponses temporelles ...
