
class Node:
    def __init__(self):
        self.childs = {}
        self.word_marker = False 

    def add_item(self, string):

        if not len(string):
            self.word_marker = True 
            return 

        key = string[0]
        string = string[1:]

        if key in self.childs:
            self.childs[key].add_item(string)
        else:
            node = Node()
            self.childs[key] = node
            node.add_item(string)

    def dfs(self, sofar=None):
        if not self.childs:
            print '  ' + sofar
            return

        if self.word_marker:
            print '  ' + sofar

        for key in sorted(self.childs.keys()):
            self.childs[key].dfs(sofar+key)

    def search(self, string, sofar=""):
        if len(string):
            key = string[0]
            string = string[1:]
            if key in self.childs:
                self.childs[key].search(string, sofar + key)
        else:
            if self.word_marker == True:
                print '  ' + sofar

            for key in sorted(self.childs.keys()):
                self.childs[key].dfs(sofar+key)

root = Node()
while True:
    try:
        command = raw_input().strip()
    except:
        break
    
    key = command[0]
    string = command[1:]
    if key == '?':
        print string
        root.search(string)
    else:
        root.add_item(string)
