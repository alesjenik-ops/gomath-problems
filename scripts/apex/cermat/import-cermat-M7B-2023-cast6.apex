String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M7B 2023 - uloha 11',
  new List<String>{'Pravouhly trojuhelnik $ABC$ je dvema useckami $CD$ a $DE$ rozdelen na tri trojuhelniky, z nichz dva jsou take pravouhle (viz obrazek). Uhly oznacene $\\omega$ jsou shodne.','Jaka je velikost uhlu $\\varphi$? Velikosti uhlu nemerte, ale vypoctete.'},
  new List<String>{'A) mensi nez $55^\\circ$','B) $55^\\circ$','C) $65^\\circ$','D) $75^\\circ$','E) vetsi nez $75^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 280" font-family="sans-serif"> <polygon points="80,240 430,240 80,70" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="80" y1="70" x2="200" y2="240" stroke="#000" stroke-width="1.5"/> <line x1="200" y1="240" x2="205" y2="130" stroke="#000" stroke-width="1.5"/> <rect x="80" y="228" width="12" height="12" fill="none" stroke="#000"/> <rect x="188" y="228" width="12" height="12" fill="none" stroke="#000"/> <text x="70" y="64" font-size="14" font-style="italic">C</text> <text x="212" y="128" font-size="14" font-style="italic">E</text> <text x="66" y="257" font-size="14" font-style="italic">A</text> <text x="196" y="259" font-size="14" font-style="italic">D</text> <text x="434" y="248" font-size="14" font-style="italic">B</text> <text x="118" y="122" font-size="13">omega</text> <text x="168" y="182" font-size="13">omega</text> <text x="150" y="233" font-size="13">fi</text> <text x="388" y="234" font-size="12">20 st.</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Pravouhly trojuhelnik ABC rozdeleny useckami CD a DE na tri trojuhelniky s vyznacenymi uhly omega, fi a 20 stupnu.',
  'Schematicky nakres k uloze 11',
  new List<String>{'Trojuhelnik $ABC$ ma pravy uhel u vrcholu $A$ a uhel pri vrcholu $B$ je $20^\\circ$, proto $\\angle ACB=70^\\circ$. Usecky $CD$ a $DE$ vytvareji dva pravouhle vnitrni trojuhelniky; z rovnosti vyznacenych uhlu $\\omega$ a ze souctu uhlu vyjde hledany uhel $\\varphi$ vetsi nez $75^\\circ$.'},
  'E) vetsi nez $75^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2023 - uloha 12',
  new List<String>{'Stavba byla vytvorena ze stejne velkych valcu tri ruznych barev. Stavba je v testovem sesitu zobrazena pri pohledu zepredu a shora.','Ktery z obrazku A-E v testovem sesitu muze predstavovat pohled na stavbu zprava?'},
  new List<String>{'A) obrazek A','B) obrazek B','C) obrazek C','D) obrazek D','E) obrazek E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif"> <text x="260" y="52" font-size="13" text-anchor="middle">Stavba ze stejne velkych valcu tri barev - pohled zepredu a shora (viz testovy sesit).</text> <text x="260" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorove pohledy nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'stavba-valce.svg',
  'Schematicka poznamka ke stavbe z valcu (pohledy nelze verne prenest).',
  'Prostorova stavba - viz testovy sesit',
  new List<String>{'Z pohledu zepredu a shora urcime rozmisteni a barvy valcu; pohledu na stavbu zprava odpovida obrazek E.'},
  'E) obrazek E',
  2, 4, '4',
  new List<String>{'zs2','r7','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2023 - uloha 13',
  new List<String>{'Kazda bytost na planete Zorstar ma prave tri nohy a zaroven ma bud tri, nebo ctyri oci. Na namesti se sesly bytosti, ktere mely dohromady 84 nohou. Mezi nimi bylo triokych bytosti o 8 vice nez ctyrokych.','Kolik oci mely dohromady vsechny bytosti, ktere se sesly na namesti?'},
  new List<String>{'A) 94 oci','B) 96 oci','C) 102 oci','D) 122 oci','E) 130 oci'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Bytosti je $84:3=28$. Oznacme ctyroke $c$, triokych je pak $c+8$. Plati $c+(c+8)=28$, tedy $c=10$ a triokych je $18$. Oci je celkem $3\\cdot 18+4\\cdot 10=54+40=94$.'},
  'A) 94 oci',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
