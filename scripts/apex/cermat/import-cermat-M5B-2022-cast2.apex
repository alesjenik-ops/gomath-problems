String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
Integer YEAR = 2022;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5B 2022 – úloha 6',
  new List<String>{'Písmeno E (na obrázku) slepené z 12 stejných bílých krychliček jsme obarvili ze všech stran (i zespodu) modrou barvou. Po čase se písmeno rozpadlo na jednotlivé krychličky. Původně slepené stěny krychliček zůstaly bílé.','6.1 Určete, kolik krychliček z rozpadlého písmene E má právě 4 stěny modré.','6.2 Určete, kolik krychliček z rozpadlého písmene E má stejný počet modrých a bílých stěn.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 230 210" font-family="sans-serif"><rect x="30" y="20" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="64" y="20" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="98" y="20" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="132" y="20" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="30" y="54" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="30" y="88" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="64" y="88" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="98" y="88" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="30" y="122" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="30" y="156" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="64" y="156" width="34" height="34" fill="#cfe0f5" stroke="#111"/><rect x="98" y="156" width="34" height="34" fill="#cfe0f5" stroke="#111"/></svg>',
  'pismeno-E.svg',
  'Písmeno E slepené z 12 stejných krychliček (schematický čelní pohled).',
  'Písmeno E z 12 krychliček (schematicky)',
  new List<String>{'Počet modrých stěn krychličky $=6-$ (počet sousedních krychliček, ke kterým byla přilepená).','6.1 Právě 4 modré stěny má krychlička se 2 sousedy; takových krychliček je 8.','6.2 Stejný počet modrých a bílých stěn (3 a 3) má krychlička se 3 sousedy; taková je jen 1 (spoj svislého sloupce s prostřední řadou).'},
  '6.1: $8$ krychliček; 6.2: $1$ krychlička',
  3, 4, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2022 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $O$ a přímka $p$ procházející bodem $O$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží vrchol $C$ tohoto obdélníku. Bod $O$ je střed některé strany obdélníku $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="240" x2="430" y2="60" stroke="#000" stroke-width="2"/> <text x="36" y="255" font-size="16" font-style="italic">p</text> <line x1="292" y1="118" x2="308" y2="130" stroke="#000" stroke-width="1"/> <text x="300" y="150" font-size="15" font-style="italic" text-anchor="middle">O</text> <text x="352" y="182" font-size="15">x</text><text x="352" y="198" font-size="15" font-style="italic">A</text> </svg>',
  'body-AO-primka-p.svg',
  'Přímka p procházející bodem O a bod A ležící mimo přímku p.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Bod $O$ je střed strany sousedící s vrcholem $A$. Protější krajní bod této strany získáme jako obraz bodu $A$ ve středové souměrnosti se středem $O$. V tomto bodě vztyčíme kolmici ke straně; její průsečík s přímkou $p$ je vrchol $C$, zbývající vrchol doplníme na obdélník. Podle volby strany (u vrcholu $A$ dvě možnosti) vzniknou dvě řešení $ABCD$.'},
  'Konstrukce obdélníku $ABCD$: $O$ je střed strany u vrcholu $A$, $C$ leží na přímce $p$; dvě řešení (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
