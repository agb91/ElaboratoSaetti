(define (domain CAMPI)
   (:types TRA TRA-ARA TRA-SEMINA contadino ARATRO SEMINATORE CAMPO)
   (:requirements :typing :adl :strips)   
   (:predicates 
		(at ?x - (either TRA contadino ARATRO SEMINATORE) ?c - CAMPO)
		(on ?c - contadino ?t - TRA)
		(coupleAra ?i - ARATRO ?t - TRA-ARA)
		(coupleSemina ?i - SEMINATORE ?t - TRA-SEMINA)
		(occupiedTractor ?t - TRA)
		(seminato ?c - CAMPO)
		(arato ?c - CAMPO)
		(innaffiato ?c - CAMPO)
		(connesso ?c1 - CAMPO ?c2 - CAMPO)
   )

   (:action goOnTractor
      :parameters (?c - contadino ?t - TRA ?campo - CAMPO)
      :precondition (and (at ?t ?campo) (at ?c ?campo))   ;;IPOTESI NON METTERA MAI 2 CONTADINI SU TRATTORE
	  :effect (and (on ?c ?t) (not (at ?c ?campo)))
   )
      
   (:action goDownTractor
      :parameters (?c - contadino ?t - TRA ?campo - CAMPO)
      :precondition (and (at ?t ?campo) (on ?c ?t))
      :effect (and (not (on ?c ?t)) (at ?c ?campo))
   )
   
   (:action moveContadino
      :parameters (?c - contadino ?from - CAMPO ?to - CAMPO)
      :precondition (and (connesso ?from ?to) (at ?c ?from) )
      :effect (and (at ?c ?to) (not (at ?c ?from)))
   )
   
   (:action moveTractor
	  :parameters (?t - TRA ?from - CAMPO ?to - CAMPO ?c - contadino)
	  :precondition (and (connesso ?from ?to) (at ?t ?from) (on ?c ?t))
	  :effect (and (at ?t ?to) (not (at ?t ?from)))
   )
  
   ;;serve che il contadino scenda dal trattore per agganciare l'attrezzo, il contadino non può essere sul trattore
   ;; l'aratro sparisce dal campo quando si lega al trattore (riappare quando si sgancia)
   (:action linkAra  
	  :parameters (?i - ARATRO ?campo - CAMPO ?c - contadino ?t - TRA-ARA)
	  :precondition (and (not (occupiedTractor ?t)) (at ?i ?campo) (at ?c ?campo) (at ?t ?campo) )
	  :effect (and (not (at ?i ?campo)) (coupleAra ?i ?t) (occupiedTractor ?t))
   )
   
   ;;serve che il contadino scenda dal trattore per agganciare l'attrezzo, il contadino non può essere sul trattore
   ;; il seminatore sparisce dal campo quando si lega al trattore (riappare quando si sgancia)
   (:action linkSemina  
	  :parameters (?i - SEMINATORE ?campo - CAMPO ?c - contadino ?t - TRA-SEMINA)
	  :precondition (and (not (occupiedTractor ?t)) (at ?i ?campo) (at ?c ?campo) (at ?t ?campo))
	  :effect (and (not (at ?i ?campo)) (coupleSemina ?i ?t) (occupiedTractor ?t))
   )
   
   (:action unLinkAra 
	  :parameters (?i - ARATRO ?campo - CAMPO ?c - contadino ?t - TRA-ARA)
	  :precondition (and (coupleAra ?i ?t) (at ?t ?campo) (at ?c ?campo)) 
	  :effect (and (at ?i ?campo) (not (coupleAra ?i ?t)) (not (occupiedTractor ?t)))
   )
   
   (:action unLinkSemina 
	  :parameters (?i - SEMINATORE ?campo - CAMPO ?c - contadino ?t - TRA-SEMINA)
	  :precondition (and (coupleSemina ?i ?t) (at ?t ?campo) (at ?c ?campo)) 
	  :effect (and (at ?i ?campo) (not (coupleSemina ?i ?t)) (not (occupiedTractor ?t)))
   )
   
   (:action ara
	  :parameters (?t - TRA-ARA ?campo - CAMPO ?c - contadino ?i - ARATRO)
	  :precondition (and (coupleAra ?i ?t) (at ?t ?campo) (on ?c ?t))
	  :effect (and (arato ?campo))
   )
   
   (:action semina
	  :parameters (?t - TRA-SEMINA ?campo - CAMPO ?c - contadino ?i - SEMINATORE)
	  :precondition (and (arato ?campo) (coupleSemina ?i ?t) (at ?t ?campo) (on ?c ?t) )
	  :effect (and (seminato ?campo))
   )
   
   (:action innaffia
	  :parameters (?campo - CAMPO ?c - contadino)
	  :precondition (and (seminato ?campo) (at ?c ?campo))
	  :effect (innaffiato ?campo)
   )
    
      
)

