String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2019 M9A · úloha 7',
  new List<String>{'Na obrázku jsou sestaveny dvě různé dvojice ozubených koleček. V první dvojici do sebe zabírají šedé kolečko s $15$ zuby a bílé kolečko s $24$ zuby. Ve druhé dvojici zabírají bílé kolečko s $24$ zuby a černé kolečko, které má méně zubů než bílé. Černé kolečko se za každých $5$ sekund otočí třikrát.','7.1 Pro první dvojici koleček určete, kolikrát se musí otočit šedé kolečko, než se poprvé obě kolečka vrátí do výchozí polohy.','7.2 Určete, kolikrát se černé kolečko otočí za $5$ minut.','7.3 Ve druhé dvojici koleček se obě kolečka vrátí do výchozí polohy poprvé po dvou otáčkách bílého kolečka. Vypočtěte, kolik zubů má černé kolečko.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: nejmenší společný násobek počtu zubů je $\\mathrm{nsn}(15,24)=120$; šedé kolečko se otočí $120:15=8$krát.','7.2: za $5$ s se černé kolečko otočí $3$krát, tedy $\\frac{3}{5}$krát za sekundu; za $5$ min $=300$ s to je $300\\cdot\\frac{3}{5}=180$krát.','7.3: dvě otáčky bílého kolečka odpovídají $2\\cdot24=48$ zubům. Černé kolečko má méně než $24$ zubů, jeho počet zubů dělí $48$ a platí $\\mathrm{nsn}(24,z)=48$; vyhovuje $z=16$ zubů.'},
  '7.1: $8$krát; 7.2: $180$krát; 7.3: $16$ zubů',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 8',
  new List<String>{'Z místa $A$ do místa $B$ šla Iva přímou cestou dlouhou $2\\ \\mathrm{km}$ (na obrázku čárkovaně). Dan šel z místa $A$ do místa $B$ vycházkovou trasou, která má tvar půlkružnice sestrojené nad úsečkou $AB$ jako průměrem (na obrázku plnou čarou).','8.1 Vypočtěte, kolikrát delší byla cesta Dana než cesta Ivy. (Výsledek zaokrouhlete na setiny.)','8.2 Vypočtěte, o kolik kilometrů více ušel Dan než Iva. (Výsledek zaokrouhlete na setiny km.)'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 54"><path d="M103 6C103 31 83 50 59 50C35 50 15 31 15 6M15 6L103 6M59 4L59 8M171 18L207 18M171 32L207 32" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="7" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="110" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="233" y="24" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Iva</text><text x="238" y="38" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Dan</text></svg>',
  'obr.svg',
  'Úsečka AB délky 2 km jako Ivina přímá cesta (čárkovaně) a půlkružnice sestrojená nad AB jako průměrem jako Danova trasa (plnou čarou); vpravo legenda Iva a Dan.',
  '',
  new List<String>{'Průměr půlkružnice je $|AB|=2\\ \\mathrm{km}$, poloměr $r=1\\ \\mathrm{km}$. Délka Danovy trasy (půlkružnice) je $\\pi r=\\pi\\doteq3{,}14\\ \\mathrm{km}$, Ivina cesta je $2\\ \\mathrm{km}$.','8.1: $\\frac{\\pi}{2}\\doteq1{,}57$, Danova cesta byla asi $1{,}57$krát delší.','8.2: $\\pi-2\\doteq3{,}14-2=1{,}14\\ \\mathrm{km}$.'},
  '8.1: $1{,}57$krát; 8.2: o $1{,}14$ km',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','slovni','bezny-zivot'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 9',
  new List<String>{'V rovině leží přímka $KL$ (viz obrázek). Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$. Velikost úhlu $LKM$ je $30^\\circ$. Vzdálenost bodu $L$ od bodu $K$ je stejná jako vzdálenost bodu $L$ od bodu $M$.','Sestrojte jeden trojúhelník $KLM$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 379 34"><path d="M4 9L375 9M268 13L268 5" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M84 5L84 13C84 14 84 14 83 14C83 14 83 14 83 13L83 5C83 4 83 4 83 4C84 4 84 4 84 5Z" style="fill:#231f20"/><text x="83" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">K</text><text x="268" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text></svg>',
  'obr.svg',
  'Přímka KL s vyznačenými body K a L.',
  '',
  new List<String>{'V bodě $K$ naneseme od polopřímky $KL$ úhel $30^\\circ$; vrchol $M$ leží na jeho rameni. Zároveň platí $|LM|=|LK|$, takže $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$. Vrchol $M$ je průsečík tohoto ramene s kružnicí.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce trojúhelníku $KLM$: $|\\angle LKM|=30^\\circ$ a $|LM|=|LK|$ (vrchol $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','uhly','rysovani'},
  'M9PAD19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
