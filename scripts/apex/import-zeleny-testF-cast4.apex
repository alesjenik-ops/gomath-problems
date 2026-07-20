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
  'Zelený F10 – konstrukce kosočtverce',
  new List<String>{'V rovině je dána úsečka $AC$.','Sestrojte kosočtverec $ABCD$, jehož délka strany je $6$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif"> <line x1="130" y1="90" x2="330" y2="270" stroke="#000" stroke-width="2.5"/> <line x1="125" y1="96" x2="135" y2="84" stroke="#000" stroke-width="2.5"/> <line x1="325" y1="276" x2="335" y2="264" stroke="#000" stroke-width="2.5"/> <text x="106" y="84" font-size="20" font-weight="bold" font-style="italic">A</text> <text x="340" y="288" font-size="20" font-weight="bold" font-style="italic">C</text> </svg>',
  'usecka-AC.svg',
  'Úsečka AC zadaná v rovině, nakloněná zleva shora doprava dolů.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Úsečka $AC$ je úhlopříčka kosočtverce. Vrcholy $B$ a $D$ leží na ose úsečky $AC$. Sestrojíme kružnice se středy $A$ a $C$ o poloměru $6$ cm; jejich průsečíky jsou vrcholy $B$ a $D$. Spojením bodů $A$, $B$, $C$, $D$ vznikne kosočtverec se stranou $6$ cm.'},
  'Kosočtverec $ABCD$ s úhlopříčkou $AC$; vrcholy $B$ a $D$ jsou průsečíky kružnic se středy $A$ a $C$ o poloměru $6$ cm (viz obrázek v klíči).',
  2, 5, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F11 – učitelský sbor (Ano/Ne)',
  new List<String>{'Tři čtvrtiny učitelského sboru naší školy tvoří ženy. Třetina učitelek a polovina učitelů umí anglicky, německy hovoří šestina učitelek a čtvrtina učitelů. Polovina učitelů (mužů) nehovoří ani jedním z těchto jazyků.','Rozhodněte na základě výchozího textu o každém z následujících tvrzení 11.1–11.3, zda může platit (A), či nikoli (N).','11.1 Na naší škole máme celkem $36$ učitelů a učitelek.','11.2 Mezi anglicky mluvícími členy učitelského sboru je dvakrát víc žen než mužů.','11.3 Žádná z učitelek nehovoří oběma jazyky.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Aby byly počty (třetina a šestina učitelek, polovina a čtvrtina učitelů) celá čísla, musí být celkový počet násobkem $16$.','11.1 Pro $36$ by bylo $27$ učitelek, jejich šestina $4{,}5$ není celé číslo — nemůže platit (Ne).','11.2 Anglicky mluví $\\frac{1}{3}$ učitelek a $\\frac{1}{2}$ učitelů, tj. při počtech $12k$ učitelek a $4k$ učitelů je to $4k$ žen a $2k$ mužů, tedy dvakrát víc žen (Ano).','11.3 Anglicky mluví $\\frac{1}{3}$ a německy $\\frac{1}{6}$ učitelek; jejich součet je $\\frac{1}{2}$ učitelek, skupiny se tedy nemusí překrývat a žádná učitelka nemusí mluvit oběma jazyky (Ano).'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  3, 7, '4',
  new List<String>{'zs2','r9','zlomky','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F12 – plnění bazénu trubkou',
  new List<String>{'Trubkou o průměru $2$ cm protéká voda rychlostí $10$ m/s. $\\pi = 3{,}14$.','Za jak dlouho naplní prázdný bazén o objemu $62{,}8$ m³?'},
  new List<String>{'A) 1.23:20 hod.','B) 3.33:33 hod.','C) 5.20:20 hod.','D) 5.33:20 hod.','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Průřez trubky $S = \\pi r^2 = 3{,}14\\cdot 0{,}01^2 = 0{,}000314$ m². Průtok $Q = S\\cdot v = 0{,}000314\\cdot 10 = 0{,}00314$ m³/s. Čas $t = \\frac{62{,}8}{0{,}00314} = 20\\,000$ s $= 5$ h $33$ min $20$ s.'},
  'D) 5.33:20 hod.',
  2, 6, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
