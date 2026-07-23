String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M7C 2021 – úloha 16',
  new List<String>{'Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší (č. 1) po nejdelší.','Obrazec má $19$ řad. Určete počet','16.1 bílých trojúhelníků v $9.$ řadě,','16.2 tmavých trojúhelníků v $16.$ řadě,','16.3 tmavých šestiúhelníků v celém obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 292 194" font-family="sans-serif"><path d="M55 18L81 18M55 18L68 41M81 18L68 41M81 18L107 18M81 18L94 41M107 18L94 41M107 18L133 18M107 18L120 41M133 18L120 41M133 18L159 18M133 18L146 41M159 18L146 41M159 18L185 18M159 18L172 41M185 18L172 41M185 18L211 18M185 18L198 41M211 18L198 41M211 18L237 18M211 18L224 41M237 18L224 41M68 41L94 41M68 41L81 63M94 41L81 63M94 41L120 41M94 41L107 63M120 41L107 63M120 41L146 41M120 41L133 63M146 41L133 63M146 41L172 41M146 41L159 63M172 41L159 63M172 41L198 41M172 41L185 63M198 41L185 63M198 41L224 41M198 41L211 63M224 41L211 63M81 63L107 63M81 63L94 86M107 63L94 86M107 63L133 63M107 63L120 86M133 63L120 86M133 63L159 63M133 63L146 86M159 63L146 86M159 63L185 63M159 63L172 86M185 63L172 86M185 63L211 63M185 63L198 86M211 63L198 86M94 86L120 86M94 86L107 108M120 86L107 108M120 86L146 86M120 86L133 108M146 86L133 108M146 86L172 86M146 86L159 108M172 86L159 108M172 86L198 86M172 86L185 108M198 86L185 108M107 108L133 108M107 108L120 131M133 108L120 131M133 108L159 108M133 108L146 131M159 108L146 131M159 108L185 108M159 108L172 131M185 108L172 131M120 131L146 131M120 131L133 153M146 131L133 153M146 131L172 131M146 131L159 153M172 131L159 153M133 153L159 153M133 153L146 176M159 153L146 176" fill="none" stroke="#bbb" stroke-width="1"/><polygon points="172,131 159,154 133,154 120,131 133,108 159,108" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="146,86 133,109 107,109 94,86 107,63 133,63" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="198,86 185,109 159,109 146,86 159,63 185,63" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="120,41 107,64 81,64 68,41 81,18 107,18" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="172,41 159,64 133,64 120,41 133,18 159,18" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="224,41 211,64 185,64 172,41 185,18 211,18" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/><polygon points="55,18 237,18 146,176" fill="none" stroke="#000" stroke-width="2"/><text x="119" y="169" font-size="12">1.</text><text x="106" y="147" font-size="12">2.</text><text x="93" y="124" font-size="12">3.</text><text x="80" y="102" font-size="12">4.</text><text x="67" y="79" font-size="12">5.</text><text x="54" y="57" font-size="12">6.</text><text x="41" y="34" font-size="12">7.</text></svg>',
  'trojuhelnikovy-obrazec.svg',
  'Trojúhelníkový obrazec o 7 řadách složený z tmavých šestiúhelníků a bílých trojúhelníků, řady číslovány zdola.',
  'Trojúhelníkový obrazec (schéma prvních řad)',
  new List<String>{'V $r$-té řadě je celkem $2r-1$ malých trojúhelníků. Tmavých je v sudé řadě $\\frac{3r}{2}$, v liché řadě (kromě první) $\\frac{3(r-1)}{2}$; ostatní jsou bílé.','16.1 Řada $9$ (lichá): tmavých $\\frac{3\\cdot 8}{2}=12$, celkem $2\\cdot 9-1=17$, bílých $17-12=5$.','16.2 Řada $16$ (sudá): tmavých $\\frac{3\\cdot 16}{2}=24$.','16.3 Šestiúhelníky tvoří pásy; mezi řadami $2j$ a $2j+1$ je $j$ šestiúhelníků. Pro $19$ řad je pásů $9$, celkem $1+2+\\dots+9=\\frac{9\\cdot 10}{2}=45$ šestiúhelníků.'},
  '16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků',
  4, 6, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
