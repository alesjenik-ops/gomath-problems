String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený A9 – množina bodů (p, A)',
  new List<String>{'V rovině leží přímka $p$ a bod $A$ vzdálený od přímky $p$ $2$ cm.','Vyznačte množinu bodů, které nejsou od přímky $p$ vzdáleny více než $1$ cm a zároveň nejsou od bodu $A$ vzdáleny více než $3$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif"> <line x1="40" y1="140" x2="380" y2="140" stroke="#000" stroke-width="2.5"/> <text x="395" y="145" font-size="18" font-style="italic">p</text> <line x1="210" y1="80" x2="210" y2="140" stroke="#000" stroke-width="1" stroke-dasharray="3 4"/> <text x="222" y="115" font-size="15">2 cm</text> <text x="210" y="72" font-size="18" text-anchor="middle" font-weight="bold">A</text> <text x="210" y="86" font-size="18" text-anchor="middle">×</text> </svg>',
  'primka-bod.svg',
  'Vodorovná přímka p a bod A ve vzdálenosti 2 cm nad přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Hledaná množina je průnik dvou útvarů: pásu všech bodů do vzdálenosti $1$ cm od přímky $p$ (mezi dvěma rovnoběžkami $p_1$, $p_2$) a kruhu se středem $A$ a poloměrem $3$ cm. Řešením je „čočka" ohraničená obloukem kružnice a rovnoběžkou $p_1$.'},
  'Konstrukce: průnik pásu do $1$ cm od přímky $p$ (mezi rovnoběžkami $p_1$, $p_2$) a kruhu se středem $A$ o poloměru $3$ cm (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený A10 – středová souměrnost čtyřúhelníku',
  new List<String>{'V rovině leží čtyřúhelník $ABCD$ a bod $S$.','Sestrojte obraz čtyřúhelníku $ABCD$ ve středové souměrnosti se středem $S$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 380" font-family="sans-serif"> <polygon points="150,60 330,175 215,320 90,255" fill="none" stroke="#000" stroke-width="2.5"/> <text x="142" y="52" font-size="18" font-weight="bold">D</text> <text x="342" y="178" font-size="18" font-weight="bold">C</text> <text x="220" y="342" font-size="18" font-weight="bold">B</text> <text x="72" y="255" font-size="18" font-weight="bold">A</text> <text x="222" y="262" font-size="18" font-weight="bold">S</text> <text x="235" y="266" font-size="16">×</text> </svg>',
  'ctyruhelnik-S.svg',
  'Čtyřúhelník ABCD a bod S ležící v jeho blízkosti.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Každý vrchol zobrazíme ve středové souměrnosti se středem $S$: bod $X\'$ leží na polopřímce opačné k $SX$ tak, že $|SX\'|=|SX|$. Spojením obrazů $A\'B\'C\'D\'$ vznikne hledaný čtyřúhelník (shodný s původním, otočený o $180^\\circ$).'},
  'Konstrukce obrazu $A\'B\'C\'D\'$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
  2, 5, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
