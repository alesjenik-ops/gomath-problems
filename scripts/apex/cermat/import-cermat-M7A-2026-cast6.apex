String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M7A 2026 - uloha 13',
  new List<String>{'Tvrdy papir tvaru obdelniku ma obsah 198 cm². Z rohu tohoto papiru odstrihneme ctyri shodne ctverce, cimz se jeho obsah zmensi o 16 cm². Potom z papiru slozime krabicku tvaru kvadru, jehoz nejdelsi hrana meri 14 cm (viz obrazek). Tloustku papiru neuvazujte.','Jakou delku mela delsi strana papiru pred odstrizenim ctvercu?'},
  new List<String>{'A) 16 cm','B) 18 cm','C) 20 cm','D) 22 cm','E) jinou delku'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 240" font-family="sans-serif"> <text x="135" y="22" font-size="12" text-anchor="middle">Papir s odstrizenymi ctverci</text> <text x="415" y="22" font-size="12" text-anchor="middle">Slozena krabicka</text> <rect x="60" y="50" width="160" height="120" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="3 3"/> <polygon points="80,50 200,50 200,70 220,70 220,150 200,150 200,170 80,170 80,150 60,150 60,70 80,70" fill="#d8d8d8" stroke="#000" stroke-width="1.5"/> <text x="140" y="196" font-size="13" font-style="italic">a</text> <text x="230" y="114" font-size="13" font-style="italic">b</text> <text x="196" y="132" font-size="13" font-style="italic">c</text> <g fill="none" stroke="#000" stroke-width="1.5"> <polygon points="330,120 460,120 460,160 330,160"/> <polyline points="330,120 358,100 488,100 460,120"/> <line x1="488" y1="100" x2="488" y2="140"/> <line x1="460" y1="160" x2="488" y2="140"/> </g> <text x="378" y="178" font-size="13" font-style="italic">a = 14 cm</text> <text x="474" y="128" font-size="13" font-style="italic">b</text> <text x="497" y="126" font-size="13" font-style="italic">c</text> </svg>',
  'papir-krabicka.svg',
  'Papir tvaru krize po odstrizeni ctyr rohovych ctvercu a slozena krabicka tvaru kvadru s hranou a rovnou 14 cm.',
  'Papir s odstrizenymi ctverci a slozena krabicka',
  new List<String>{'Ctyri shodne ctverce maji obsah $16$ cm², tj. jeden ctverec $4$ cm², jeho strana $c=2$ cm. Dno krabicky ma rozmery $a\\times b$, vyska $c=2$ cm; nejdelsi hrana $a=14$ cm. Delsi strana papiru $=a+2c=14+4=18$ cm.'},
  'B) 18 cm',
  2, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2026 - uloha 14',
  new List<String>{'Tvrdy papir tvaru obdelniku ma obsah 198 cm². Z rohu tohoto papiru odstrihneme ctyri shodne ctverce, cimz se jeho obsah zmensi o 16 cm². Potom z papiru slozime krabicku tvaru kvadru, jehoz nejdelsi hrana meri 14 cm (viz obrazek). Tloustku papiru neuvazujte.','Jaky je objem krabicky?'},
  new List<String>{'A) 168 cm³','B) 196 cm³','C) 308 cm³','D) 396 cm³','E) jiny objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 240" font-family="sans-serif"> <text x="135" y="22" font-size="12" text-anchor="middle">Papir s odstrizenymi ctverci</text> <text x="415" y="22" font-size="12" text-anchor="middle">Slozena krabicka</text> <rect x="60" y="50" width="160" height="120" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="3 3"/> <polygon points="80,50 200,50 200,70 220,70 220,150 200,150 200,170 80,170 80,150 60,150 60,70 80,70" fill="#d8d8d8" stroke="#000" stroke-width="1.5"/> <text x="140" y="196" font-size="13" font-style="italic">a</text> <text x="230" y="114" font-size="13" font-style="italic">b</text> <text x="196" y="132" font-size="13" font-style="italic">c</text> <g fill="none" stroke="#000" stroke-width="1.5"> <polygon points="330,120 460,120 460,160 330,160"/> <polyline points="330,120 358,100 488,100 460,120"/> <line x1="488" y1="100" x2="488" y2="140"/> <line x1="460" y1="160" x2="488" y2="140"/> </g> <text x="378" y="178" font-size="13" font-style="italic">a = 14 cm</text> <text x="474" y="128" font-size="13" font-style="italic">b</text> <text x="497" y="126" font-size="13" font-style="italic">c</text> </svg>',
  'papir-krabicka.svg',
  'Papir tvaru krize po odstrizeni ctyr rohovych ctvercu a slozena krabicka tvaru kvadru s hranou a rovnou 14 cm.',
  'Papir s odstrizenymi ctverci a slozena krabicka',
  new List<String>{'Strana odstrizenych ctvercu $c=2$ cm. Delsi strana papiru $18$ cm, kratsi $198:18=11$ cm. Dno krabicky $a=18-4=14$ cm, $b=11-4=7$ cm, vyska $c=2$ cm. Objem $14\\cdot 7\\cdot 2=196$ cm³.'},
  'B) 196 cm³',
  2, 3, '2',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
